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

  describe '.scanned_latest' do
    before { allow_any_instance_of(Website).to receive(:check_website) }

    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:admin) { create(:user, admin: true) }
    let!(:website1) { create(:website, url: 'http://website1.com', user: user) }
    let!(:website1_new) { create(:website, url: 'http://website1.com', user: user) }
    let!(:website2) { create(:website, url: 'http://website2.com', user: user) }
    let!(:website_another) { create(:website, url: 'http://website_another.com', user: another_user) }

    it 'calls scanned_latest for admin' do
      expect(Website.scanned_latest(admin)).to contain_exactly(website1_new, website2, website_another)
    end

    it 'calls scanned_latest for user' do
      expect(Website.scanned_latest(user)).to contain_exactly(website1_new, website2)
    end

    it 'calls scanned_latest for guest' do
      expect(Website.scanned_latest(nil)).to be_nil
    end
  end
end
