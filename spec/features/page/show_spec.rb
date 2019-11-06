require 'rails_helper'

ActiveRecord::Base.skip_callbacks = false

feature 'User can submit website for analysis' do
  given(:website) { create(:website) }

  vcr_options = { :record => :new_episodes }

  scenario 'see report for page', vcr: vcr_options do
    website.pages.first.contents = file_fixture("delphsite.html").read
    Services::PageStructure.call(website.pages.first)

    visit page_path(website.pages.first)

    save_and_open_page
    #
    # expect(page).to have_content 'Report'
    # expect(page).to have_content website.pages.first.path
  end
end
