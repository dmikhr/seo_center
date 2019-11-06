require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:website) { create(:website) }
  let(:page) { create(:page, website: website, contents: file_fixture("delphsite.html").read) }

  vcr_options = { :record => :new_episodes }

  describe 'GET #show', vcr: vcr_options do
    before { get :show, params: { id: page } }

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'POST #parse', vcr: vcr_options do

    context 'with valid attributes' do
      it 'redirects to show view' do
        post :parse, params: { id: page }
        expect(response).to redirect_to assigns(:page)
      end
    end

    # context 'with invalid attributes' do
    #   it 'does not save the website' do
    #     expect { post :create, params: { website: attributes_for(:website, :invalid) } }.to_not change(Website, :count)
    #   end
    #
    #   it 're-renders new view' do
    #     post :create, params: { website: attributes_for(:website, :invalid) }
    #     expect(response).to render_template :new
    #   end
    # end
  end
end
