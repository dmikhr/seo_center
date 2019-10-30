class Page < ApplicationRecord
  belongs_to :website

  validates :path, presence: true
end
