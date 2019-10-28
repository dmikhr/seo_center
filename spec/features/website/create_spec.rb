require 'rails_helper'

feature 'User can submit website for analysis' do
  background { visit root_path }
  scenario 'submit website' do
    fill_in 'Url', with: 'https://guides.rubyonrails.org'
    click_on 'Analyze'

    expect(page).to have_content 'Report for website'
    expect(page).to have_link  'https://guides.rubyonrails.org', href: 'https://guides.rubyonrails.org'
  end
end
