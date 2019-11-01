require 'rails_helper'

RSpec.describe Services::PageStructure do
  let(:page) { create(:page) }
  let(:meta) { create(:meta, page: page) }

  vcr_options = { :record => :new_episodes }

  it 'call Services::PageStructure service', vcr: vcr_options do
    expect(Services::PageStructure).to receive(:call).with(page)
    Services::PageStructure.call(page)
  end

  # it 'parse html page', vcr: vcr_options do
  #   page.contents = file_fixture("delphsite.html").read
  #   Services::PageStructure.call(page)
  # end
end
