require 'rails_helper'

feature 'Admin can see a list of users' do

  given!(:users) { create_list(:user, 3) }
  given(:admin) { create(:user, admin: true) }

  describe 'Admin' do
    background { sign_in(admin) }

    scenario 'see all users' do
      visit admin_users_path

      users.each { |user| expect(page).to have_content user.email }
    end
  end

  describe 'User' do
    background { sign_in(users.first) }

    scenario 'cannot see all users' do
      visit admin_users_path

      expect(page).to have_content 'You are not authorized to access this page.'
    end
  end

  describe 'Guest' do
    scenario 'cannot see all users' do
      visit admin_users_path

      expect(page).to have_content 'Log In'
    end
  end
end
