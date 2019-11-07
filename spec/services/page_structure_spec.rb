require 'rails_helper'

RSpec.describe Services::PageStructure do
  let(:user) { create(:user) }
  let(:website) { build(:website, user: user) }
  let(:page) { create(:page, website: website) }

  vcr_options = { :record => :new_episodes }

  it 'call Services::PageStructure service', vcr: vcr_options do
    expect(Services::PageStructure).to receive(:call).with(page)
    Services::PageStructure.call(page)
  end

  it 'parse html page', vcr: vcr_options do
    page.contents = file_fixture("delphsite.html").read
    Services::PageStructure.call(page)
    # byebug
  end
end
