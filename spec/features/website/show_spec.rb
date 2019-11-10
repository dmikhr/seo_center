require 'rails_helper'

feature 'User can see report for submitted website' do

  before { allow_any_instance_of(Website).to receive(:check_website) }

  given(:user) { create(:user) }
  given!(:website) { create(:website, user: user) }
  given!(:pages) { create_list(:page, 3, website: website) }
  given!(:website_old1) { create(:website,
                                 scanned_time: Time.at(Time.now.to_i - 10000),
                                 user: user) }
  given!(:website_old2) { create(:website,
                                  scanned_time: Time.at(Time.now.to_i - 20000),
                                  user: user) }
  given(:another_user) { create(:user) }
  given!(:website2) { create(:website, user: another_user) }

  describe 'Authenticated user' do
    background { sign_in(user) }

    scenario 'see report' do
      visit website_path(website)

      expect(page).to have_content 'Report for website'
      expect(page).to have_content 'www'
      expect(page).to have_content 'https'
      expect(page).to have_link  website.url, href: website.url

      within '.pages_list' do
        website.pages.each do |website_page|
          expect(page).to have_link  website_page.path, href: website_page.path
        end
      end
    end

    scenario 'tries to see report for website of another user' do
      visit website_path(website2)

      expect(page).to have_content 'You are not authorized to access this page'
    end

    scenario 'analyze page' do
      visit website_path(website)

      website.pages.first.contents = file_fixture("delphsite.html").read

      # click_on Analyze для первой страницы сайта
      path = "/pages/#{website.pages.first.id}/parse"
      # for link
      find(:xpath, "//a[@href='#{path}']").click
      # for button
      # find(:xpath, "//form[@action='#{path}']").click
      # save_and_open_page

      expect(page).to have_content 'Report'
      expect(page).to have_content website.pages.first.path
    end
  end

  describe 'Guest' do
    scenario 'cannot see report' do
      visit website_path(website)

      expect(page).to_not have_content 'Report for website'
      expect(page).to_not have_content 'www'
      expect(page).to_not have_content 'https'
      expect(page).to_not have_link  website.url, href: website.url

      expect(page).to have_content 'Log in'
    end

    scenario 'tries to access website page' do
      visit website_path(website)

      expect(page).to have_content 'Log in'
    end
  end
end
