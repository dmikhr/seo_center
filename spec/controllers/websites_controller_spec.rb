require 'rails_helper'

RSpec.describe WebsitesController, type: :controller do

  before { allow_any_instance_of(Website).to receive(:check_website) }

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let!(:website) { create(:website, scanned_time: Time.at(Time.now.to_i - 1000), user: user) }
  let!(:website_newest) { create(:website, user: user) }
  let!(:website2) { create(:website, url: 'http://website2.local', user: user) }
  let!(:website_another) { create(:website, url: 'http://another.local', user: another_user) }

  describe 'User' do
    before { login(user) }

    describe 'GET #new' do
      before { get :new }

      it 'assigns a new Website to @website' do
        expect(assigns(:website)).to be_a_new(Website)
      end

      it 'renders new view' do
        expect(response).to render_template :new
      end
    end

    describe 'GET #index' do
      before { get :index }

      it 'populates an array of websites of current user' do
        expect(assigns(:websites)).to eq([website_newest, website2])
        # список сайтов current_user отображает последнюю версию сайта,
        # если он сканировался несколько раз
        expect(assigns(:websites)).to_not eq([website])
        # нельзя увидеть в своем списке сайты других пользователей
        expect(assigns(:websites)).to_not eq([website_another])
      end

      it 'renders index view' do
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      it 'renders show view' do
        get :show, params: { id: website }
        expect(response).to render_template :show
      end

      it 'tries to view website of another user' do
        get :show, params: { id: website_another }
        expect(response).to redirect_to root_path
      end
    end

    describe 'POST #create' do
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

  describe 'Admin' do
    before { login(admin) }

    describe 'GET #index' do
      before { get :index }

      it 'populates an array of websites of all users' do
        expect(assigns(:websites)).to contain_exactly(website2, website_another, website_newest)
      end

      it 'renders index view' do
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      it 'can view website of another user' do
        get :show, params: { id: website }
        expect(response).to render_template :show
      end
    end
  end

  describe 'Guest' do

    describe 'GET #new' do
      before { get :new }

      it 'cannot assign a new Website to @website' do
        expect(assigns(:website)).to be_nil
      end

      it 'redirected to login page' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET #show' do
      before { get :show, params: { id: website } }

      it 'redirected to login page' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'POST #create' do
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
