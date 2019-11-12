require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do

  before { allow_any_instance_of(Website).to receive(:check_website) }

  let(:users) { create_list(:user, 3) }
  let(:admin) { create(:user, admin: true) }
  let(:website) { create(:website, user: users.first) }

  describe 'Admin' do
    before { login(admin) }

    describe 'GET #index' do
      before { get :index }

      it 'populates an array of users ' do
        expect(assigns(:users)).to eq(users)
      end

      it 'website belongs to user' do
        expect(website.user_id).to eq(users.first.id)
      end

      it 'renders index view' do
        expect(response).to render_template :index
      end
    end
  end

  describe 'User' do
    before { login(users.first) }

    describe 'GET #index' do
      before { get :index }

      it 'cannot populate an array of users ' do
        expect(assigns(:users)).to_not eq(users)
      end

      it 'renders index view' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'Guest' do

    describe 'GET #index' do
      before { get :index }

      it 'cannot populate an array of users ' do
        expect(assigns(:users)).to_not eq(users)
      end

      it 'renders index view' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
