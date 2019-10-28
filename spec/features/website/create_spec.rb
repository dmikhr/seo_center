require 'rails_helper'

feature 'User can submit website for analysis' do

  background { visit root_path }

  scenario 'submit website', :vcr do
    fill_in 'Url', with: 'https://stackoverflow.com'
    click_on 'Analyze'

    expect(page).to have_content 'Report for website'
    expect(page).to have_link  'https://stackoverflow.com', href: 'https://stackoverflow.com'
  end
end
