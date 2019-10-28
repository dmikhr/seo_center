require 'rails_helper'

feature 'User can see report for submitted website' do
  given(:website) { create(:website) }
  given(:website_in_progress) { create(:website, :in_progress) }

  scenario 'see report', :vcr do
    visit website_path(website)

    expect(page).to have_content 'Report for website'
    expect(page).to have_content 'www'
    expect(page).to have_content 'https'
    expect(page).to have_link  website.url, href: website.url
  end
end
