require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:website) { create(:website) }
  let(:page) { create(:page, website: website, contents: file_fixture("delphsite.html").read) }
  let(:user) { create(:user) }

  vcr_options = { :record => :new_episodes }

  describe 'User' do
    before { login(user) }

    describe 'GET #show', vcr: vcr_options do


      before { get :show, params: { id: page } }

      it 'renders show view' do
        expect(response).to render_template :show
      end
    end

    describe 'POST #parse', vcr: vcr_options do

      it 'save parsing results' do
        [Image, Htag, Link].each do |model|
          expect { post :parse, params: { id: page } }.to change(model, :count).by_at_least(1)
        end
      end

      it 'redirects to page report view' do
        post :parse, params: { id: page }
        expect(response).to redirect_to assigns(:page)
      end

      it 'tries to parse nonexistent page' do
        expect { post :parse, params: { id: 111112222 } }.to raise_exception ActiveRecord::RecordNotFound
      end
    end
  end

  describe 'Guest' do

    describe 'GET #show', vcr: vcr_options do

      before { get :show, params: { id: page } }

      it 'do not save parsing results' do
        [Image, Htag, Link].each do |model|
          expect { post :parse, params: { id: page } }.to_not change(model, :count)
        end
      end

      it 'renders show view' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'POST #parse', vcr: vcr_options do

      it 'redirects to login page' do
        post :parse, params: { id: page }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
