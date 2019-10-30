require 'rails_helper'

RSpec.describe Services::PageStructure do
  let(:page) { build(:page) }

  it 'parse html page' do
    expect(Services::PageStructure).to receive(:call).with(page)
    Services::PageStructure.call(page)
  end
end
