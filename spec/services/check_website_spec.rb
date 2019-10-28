require 'rails_helper'

RSpec.describe Services::CheckWebsite do
  let(:website) { create(:website) }

  it 'checks website' do
    expect(Services::CheckWebsite).to receive(:call).with(website.url)
    Services::CheckWebsite.call(website.url)
  end
end
