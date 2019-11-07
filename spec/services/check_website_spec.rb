require 'rails_helper'

RSpec.describe Services::CheckWebsite do
  let(:user) { create(:user) }
  let(:website) { build(:website, user: user) }

  it 'checks website' do
    expect(Services::CheckWebsite).to receive(:call).with(website)
    Services::CheckWebsite.call(website)
  end
end
