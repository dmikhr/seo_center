require 'rails_helper'

RSpec.describe Services::PageDownloader do
  let(:website) { build(:website) }

  it 'downloads page' do
    expect(Services::PageDownloader).to receive(:call).with(website.url)
    Services::PageDownloader.call(website.url)
  end
end
