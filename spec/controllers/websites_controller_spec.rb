require 'rails_helper'

RSpec.describe WebsitesController, type: :controller do
  let(:website) { create(:website) }

  describe 'GET #new' do

    before { get :new }

    it 'assigns a new Website to @website' do
      expect(assigns(:website)).to be_a_new(Website)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: website } }

    it 'renders show view' do
      expect(response).to render_template :show
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
