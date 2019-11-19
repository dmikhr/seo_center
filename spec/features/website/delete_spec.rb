require 'rails_helper'

feature 'User can see report for submitted website' do

  before { allow_any_instance_of(Website).to receive(:check_website) }

  given(:user) { create(:user) }
  given(:admin) { create(:user, admin: true) }
  given!(:website) { create(:website, url: 'http://website.com', user: user) }
  given!(:website2) { create(:website, url: 'http://website2.com', user: user) }
  given!(:website_old1) { create(:website, url: 'http://website.com',
                                 scanned_time: Time.at(Time.now.to_i - 10000),
                                 user: user) }
  given!(:website_old2) { create(:website, url: 'http://website.com',
                                  scanned_time: Time.at(Time.now.to_i - 20000),
                                  user: user) }

  describe 'Authenticated user' do
    background { sign_in(user) }

    scenario 'delete report of own website' do
      visit website_path(website)

      click_on 'Delete report'

      within '.websites' do
        expect(page).to_not have_link  website.url, href: website_path(website)
        expect(page).to have_link  website2.url, href: website_path(website2)
      end
      expect(page).to_not have_content  'Delete report'
    end

    scenario 'delete all reports related to own website' do
      visit website_path(website)

      click_on 'Delete all history'

      within '.websites' do
        expect(page).to_not have_link  website.url, href: website_path(website)
        expect(page).to_not have_link  website_old1.url, href: website_path(website_old1)
        expect(page).to_not have_link  website_old2.url, href: website_path(website_old2)
        expect(page).to have_link  website2.url, href: website_path(website2)
      end
      expect(page).to_not have_content 'Delete all history'
    end
  end

  describe 'Admin' do
    background { sign_in(admin) }

    scenario 'delete any report' do
      visit website_path(website)

      click_on 'Delete report'

      within '.websites' do
        expect(page).to_not have_link  website.url, href: website_path(website)
        expect(page).to have_link  website2.url, href: website_path(website2)
      end
      expect(page).to_not have_content  'Delete report'
    end

    scenario 'delete all reports related to any website' do
      visit website_path(website)

      click_on 'Delete all history'

      within '.websites' do
        expect(page).to_not have_link  website.url, href: website_path(website)
        expect(page).to_not have_link  website_old1.url, href: website_path(website_old1)
        expect(page).to_not have_link  website_old2.url, href: website_path(website_old2)
        expect(page).to have_link  website2.url, href: website_path(website2)
      end
      expect(page).to_not have_content 'Delete all history'
    end
  end
end
