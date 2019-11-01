require 'rails_helper'

RSpec.describe Services::PageStructure do
  let(:page) { create(:page) }

  vcr_options = { :record => :new_episodes }

  it 'call Services::PageStructure service', vcr: vcr_options do
    expect(Services::PageStructure).to receive(:call).with(page)
    Services::PageStructure.call(page)
  end
end
