require 'rails_helper'

feature 'User can submit website for analysis' do

  # https://relishapp.com/vcr/vcr/v/2-9-3/docs/record-modes/new-episodes
  vcr_options = { :record => :new_episodes }

  scenario 'submit website', vcr: vcr_options do
    visit root_path

    fill_in 'Url', with: 'https://stackoverflow.com'
    click_on 'Analyze'

    expect(page).to have_content 'Report for website'
    expect(page).to have_link  'https://stackoverflow.com', href: 'https://stackoverflow.com'
  end
end
