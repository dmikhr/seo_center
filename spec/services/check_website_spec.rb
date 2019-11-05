require 'rails_helper'

RSpec.describe Services::CheckWebsite do
  let(:website) { build(:website) }

  it 'checks website' do
    expect(Services::CheckWebsite).to receive(:call).with(website)
    Services::CheckWebsite.call(website)
  end
end
