require 'rails_helper'

feature 'User can submit website for analysis' do
  given(:website) { create(:website) }
  given(:user) { create(:user) }
  # https://relishapp.com/vcr/vcr/v/2-9-3/docs/record-modes/new-episodes
  vcr_options = { :record => :new_episodes }

  describe 'Authenticated user' do
    background { sign_in(user) }

    scenario 'submit website', vcr: vcr_options do
      visit root_path

      fill_in 'Url', with: website.url
      click_on 'Analyze'

      expect(page).to have_content 'Report for website'
      expect(page).to have_link  website.url, href: website.url
      # save_and_open_page
    end

    scenario 'tries to submit empty string'do
      visit root_path

      click_on 'Analyze'

      expect(page).to have_content "Url can't be blank"
      expect(page).to_not have_content 'Report for website'
    end

    scenario 'tries to submit invalid url' do
      visit root_path

      fill_in 'Url', with: 'sometext'
      click_on 'Analyze'

      expect(page).to have_content "URL is not valid"
      expect(page).to_not have_content 'Report for website'
    end
  end

  scenario 'Unauthenticated user tries to submit website' do
    visit root_path
    # save_and_open_page
    # expect(page).to_not have_content 'Ask question'
  end
end
