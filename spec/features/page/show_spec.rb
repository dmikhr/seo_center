# require 'rails_helper'
#
# # без этих строк этот тест падает с ошибкой undefined method `visit'
# # https://stackoverflow.com/questions/40293144/undefined-method-visit-for-object-nomethoderror-capybara-rspec
# require 'capybara/dsl'
# include Capybara::DSL
#
# ActiveRecord::Base.skip_callbacks = false
#
# feature 'see report for page' do
#   # given(:website) { create(:website) }
#   given(:page) { create(:page) }
#
#   vcr_options = { :record => :new_episodes }
#
#   scenario 'see report for page', vcr: vcr_options do
#     page.contents = file_fixture("delphsite.html").read
#     # website.pages.first.contents = file_fixture("delphsite.html").read
#     Services::PageStructure.call(page)
#     # byebug
#     visit page_path(page)
#
#     save_and_open_page
#     #
#     # expect(page).to have_content 'Report'
#     # expect(page).to have_content website.pages.first.path
#   end
# end
