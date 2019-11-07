require 'rails_helper'

RSpec.describe WebsitesController, type: :controller do
  let(:website) { create(:website) }
  let(:user) { create(:user) }

  vcr_options = { :record => :new_episodes }

  describe 'User' do
    before { login(user) }

    describe 'GET #new', vcr: vcr_options do
      before { get :new }

      it 'assigns a new Website to @website' do
        expect(assigns(:website)).to be_a_new(Website)
      end

      it 'renders new view' do
        expect(response).to render_template :new
      end
    end

    describe 'GET #show', vcr: vcr_options do
      before { get :show, params: { id: website } }

      it 'renders show view' do
        expect(response).to render_template :show
      end
    end

    describe 'POST #create', vcr: vcr_options do
      context 'with valid attributes' do
        it 'saves a new website in the database' do
          expect { post :create, params: { website: attributes_for(:website) } }.to change(Website, :count).by(1)
        end

        it 'redirects to show view' do
          post :create, params: { website: attributes_for(:website) }
          expect(response).to redirect_to assigns(:website)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the website' do
          expect { post :create, params: { website: attributes_for(:website, :invalid) } }.to_not change(Website, :count)
        end

        it 're-renders new view' do
          post :create, params: { website: attributes_for(:website, :invalid) }
          expect(response).to render_template :new
        end
      end
    end
  end

  describe 'Guest' do

    describe 'GET #new', vcr: vcr_options do
      before { get :new }

      it 'cannot assign a new Website to @website' do
        expect(assigns(:website)).to be_nil
      end

      it 'redirected to login page' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET #show', vcr: vcr_options do
      before { get :show, params: { id: website } }

      it 'redirected to login page' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'POST #create', vcr: vcr_options do
      context 'with valid attributes' do
        it 'cannot saves a new website in the database' do
          expect { post :create, params: { website: attributes_for(:website) } }.to_not change(Website, :count)
        end

        it 'redirects to show view' do
          post :create, params: { website: attributes_for(:website) }
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end
end
