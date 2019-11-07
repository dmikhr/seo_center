require 'rails_helper'

RSpec.describe Website, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:pages).dependent(:destroy) }

  it { should validate_presence_of :url }

  it { should allow_value("https://exmaple.com/11111").for(:url) }
  it { should_not allow_value("not a valid url").for(:url) }

  describe 'check' do
    let(:user) { create(:user) }
    let(:website) { build(:website, user: user) }

    it 'calls CheckWebsiteJob' do
      expect(CheckWebsiteJob).to receive(:perform_now).with(website)
      website.save!
    end
  end
end
