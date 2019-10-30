require 'rails_helper'

RSpec.describe Page, type: :model do
  it { should belong_to :website }

  it { should validate_presence_of :path }
end
