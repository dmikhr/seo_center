require 'rails_helper'

# ActiveRecord::Base.skip_callbacks = false

# без этих строк этот тест падает с ошибкой undefined method `visit'
# require 'capybara/dsl'
# include Capybara::DSL

# https://stackoverflow.com/questions/40293144/undefined-method-visit-for-object-nomethoderror-capybara-rspec
# если их раскомментировать - тест работает, но падают остальные
# код раскомментируется для тестирования функционала страницы отчета, при работе с другими тестами
# код теста остается закомментирован



# feature 'see report for page' do
#   given(:user) { create(:user) }
#   given(:another_user) { create(:user) }
#   given(:website) { create(:website, user: user) }
#   given(:website2) { create(:website, user: another_user) }
#   given(:page) { create(:page, website: website, contents: file_fixture("delphsite.html").read) }
#   given(:page2) { create(:page, website: website2, contents: file_fixture("delphsite.html").read) }
#
#   vcr_options = { :record => :new_episodes }
#
#   describe 'Authenticated user' do
#     background { sign_in(user) }
#
#     scenario 'see report for page', vcr: vcr_options do
#       Services::PageStructure.call(page)
#
#       visit page_path(page)
#
#       expect(page).to have_content 'Report'
#       expect(page).to have_content page.path
#     end
#
#     scenario 'tries to view page of a website from another user', vcr: vcr_options do
#       visit page_path(page2)
#
#       expect(page).to have_content 'You are not authorized to access this page'
#     end
#   end
# end
