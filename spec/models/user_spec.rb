require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  it { should have_many(:websites).dependent(:destroy) }

  describe 'Admin' do
    let!(:admin) { create(:user, admin: true) }
    let!(:user) { create(:user) }

    it 'respond to admin' do
      expect(admin.admin?).to be_truthy
      expect(user.admin?).to be_falsey
    end
  end
end
