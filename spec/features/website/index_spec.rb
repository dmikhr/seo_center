require 'rails_helper'

feature 'User can see the list for submitted websites' do

  before { allow_any_instance_of(Website).to receive(:check_website) }

  given(:user) { create(:user) }
  given(:admin) { create(:user, admin: true) }
  given(:another_user) { create(:user) }
  given!(:website1) { create(:website, url: 'http://website1.com', user: user) }
  given!(:website1_old) { create(:website,
                                 scanned_time: Time.at(Time.now.to_i - 1000),
                                 url: 'http://website1.com', user: user) }
  given!(:website2) { create(:website, url: 'http://website2.com', user: user) }
  given!(:website2_old) { create(:website,
                                 scanned_time: Time.at(Time.now.to_i - 1000),
                                 url: 'http://website2.com', user: user) }
  given!(:website_another) { create(:website, url: 'http://website_another.com', user: another_user) }

  describe 'Authenticated user' do
    background { sign_in(user) }

    scenario 'see only own submitted websites of latest versions' do
      visit websites_path

      expect(page).to have_link  'My websites', href: websites_path

      within '.websites' do
        expect(page).to have_link  website1.url, href: website_path(website1)
        expect(page).to have_link  website2.url, href: website_path(website2)

        expect(page).to_not have_link  website1_old.url, href: website_path(website1_old)
        expect(page).to_not have_link  website2_old.url, href: website_path(website2_old)

        expect(page).to_not have_link  website_another.url, href: website_path(website_another)
      end
    end
  end

  describe 'Admin' do
    background { sign_in(admin) }

    scenario 'see all submitted websites of latest versions' do
      visit websites_path

      expect(page).to have_link  'Manage websites', href: websites_path

      within '.websites' do
        expect(page).to have_link  website1.url, href: website_path(website1)
        expect(page).to have_link  website2.url, href: website_path(website2)
        expect(page).to have_link  website_another.url, href: website_path(website_another)

        expect(page).to_not have_link  website1_old.url, href: website_path(website1_old)
        expect(page).to_not have_link  website2_old.url, href: website_path(website2_old)
      end
    end
  end

  describe 'Guest' do
    scenario 'cannot see any websites' do
      visit websites_path

      expect(page).to_not have_link  nil, href: websites_path

      expect(page).to_not have_link  website1.url, href: website_path(website1)
      expect(page).to_not have_link  website2.url, href: website_path(website2)
      expect(page).to_not have_link  website_another.url, href: website_path(website_another)
      expect(page).to_not have_link  website1_old.url, href: website_path(website1_old)
      expect(page).to_not have_link  website2_old.url, href: website_path(website2_old)

      expect(page).to have_content 'Log in'
    end
  end
end
