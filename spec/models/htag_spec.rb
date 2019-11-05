require 'rails_helper'

RSpec.describe Htag, type: :model do
  it { should belong_to :page }

  it { should validate_numericality_of(:level).only_integer.is_greater_than_or_equal_to(1)
        .is_less_than_or_equal_to(6) }
end
