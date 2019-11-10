require 'rails_helper'

feature 'User can submit website for analysis' do

  before { allow_any_instance_of(Website).to receive(:check_website) }

  given(:user) { create(:user) }
  given(:website) { create(:website, user: user) }

  describe 'Authenticated user' do
    background { sign_in(user) }

    scenario 'submit website' do
      visit root_path

      fill_in 'Url', with: website.url
      click_on 'Analyze'

      expect(page).to have_content 'Report for website'
      expect(page).to have_link  website.url, href: website.url
    end

    scenario 'tries to submit empty string' do
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

    expect(page).to have_content 'Log in'
  end
end
