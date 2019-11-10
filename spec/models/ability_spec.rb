require 'rails_helper'
require "cancan/matchers"

describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }
  # stub callback with parser call
  before { allow_any_instance_of(Website).to receive(:check_website) }

  describe 'for admin' do
    let(:user) { create :user, admin: true }

    it { should be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create :user }
    let(:other) { create :user }
    let(:website) { create(:website, user: user) }
    let(:website_other) { create(:website, user: other) }
    let(:page) { create(:page, website: website) }
    let(:page_other) { create(:page, website: website_other) }

    context 'Website' do
      it { should be_able_to :manage, website }
      it { should_not be_able_to :manage, website_other }
    end

    context 'Page' do
      it { should be_able_to :manage, page }
      it { should_not be_able_to :manage, page_other }
    end
  end
end
