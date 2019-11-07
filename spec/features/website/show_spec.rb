require 'rails_helper'

feature 'User can see report for submitted website' do
  given(:user) { create(:user) }
  given(:website) { create(:website, user: user) }
  given(:website_in_progress) { create(:website, :in_progress) }

  vcr_options = { :record => :new_episodes }

  describe 'Authenticated user' do
    background { sign_in(user) }

    scenario 'see report', vcr: vcr_options do
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

    scenario 'analyze page', vcr: vcr_options do
      visit website_path(website)

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
    scenario 'cannot see report', vcr: vcr_options do
      visit website_path(website)

      expect(page).to_not have_content 'Report for website'
      expect(page).to_not have_content 'www'
      expect(page).to_not have_content 'https'
      expect(page).to_not have_link  website.url, href: website.url

      expect(page).to have_content 'Log in'
    end

    scenario 'tries to access website page', vcr: vcr_options do
      visit website_path(website)

      expect(page).to have_content 'Log in'
    end
  end
end
