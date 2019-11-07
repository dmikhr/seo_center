require 'rails_helper'

RSpec.describe Services::PageDownloader do
  let(:user) { create(:user) }
  let(:website) { build(:website, user: user) }

  it 'downloads page' do
    expect(Services::PageDownloader).to receive(:call).with(website.url)
    Services::PageDownloader.call(website.url)
  end
end
