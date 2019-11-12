require 'rails_helper'

RSpec.describe Services::PageStructure do

  before { allow_any_instance_of(Website).to receive(:check_website) }

  let(:user) { create(:user) }
  let(:website) { build(:website, user: user) }
  let(:page) { create(:page, website: website) }

  it 'call Services::PageStructure service' do
    expect(Services::PageStructure).to receive(:call).with(page)
    Services::PageStructure.call(page)
  end

  it 'parse html page' do
    page.contents = file_fixture("delphisite.html").read
    Services::PageStructure.call(page)
  end
end
