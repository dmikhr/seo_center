require 'rails_helper'

RSpec.describe Meta, type: :model do
  it { should belong_to :page }
end
