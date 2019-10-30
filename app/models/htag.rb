class Htag < ApplicationRecord
  belongs_to :page

  # h1..h6
  validates :type, numericality: { only_integer: true,
                                   greater_than_or_equal_to: 1,
                                   less_than_or_equal_to: 6 }
end
