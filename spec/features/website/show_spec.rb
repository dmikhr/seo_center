require 'rails_helper'

feature 'User can see report for submitted website' do

  before { allow_any_instance_of(Website).to receive(:check_website) }

  given(:user) { create(:user) }
  given(:admin) { create(:user, admin: true) }
  given!(:website) { create(:website, url: 'http://website.com', user: user) }
  given!(:website2) { create(:website, url: 'http://website2.com', user: user) }
  given!(:pages) { create_list(:page, 3, website: website) }
  given!(:website_old1) { create(:website, url: 'http://website.com',
                                 scanned_time: Time.at(Time.now.to_i - 10000),
                                 user: user) }
  given!(:website_old2) { create(:website, url: 'http://website.com',
                                  scanned_time: Time.at(Time.now.to_i - 20000),
                                  user: user) }
  given(:another_user) { create(:user) }
  given!(:website_another) { create(:website, url: 'http://website_another.com', user: another_user) }

  describe 'Authenticated user', js: true do
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

    scenario 'select version of report' do
      visit website_path(website)

      expect(page).to have_content "Scanned time: #{website.scanned_time.strftime("%Y-%m-%d %H:%M:%S")} UTC"
      # выбрать из выпадающего списка другуию версию отчета для этого сайта
      select website_old1.scanned_time.strftime("%Y-%m-%d %H:%M:%S UTC"), from: "website_scanned_time"
      expect(page).to have_content "Scanned time: #{website_old1.scanned_time.strftime("%Y-%m-%d %H:%M:%S")} UTC"
    end

    scenario 'tries to see report for website of another user' do
      visit website_path(website_another)

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

  describe 'Admin' do
    background { sign_in(admin) }

    scenario 'see any report' do
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

    scenario 'analyze any page' do
      visit website_path(website)

      website.pages.first.contents = file_fixture("delphsite.html").read

      path = "/pages/#{website.pages.first.id}/parse"
      find(:xpath, "//a[@href='#{path}']").click

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
