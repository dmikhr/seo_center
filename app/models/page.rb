class Page < ApplicationRecord
  belongs_to :website
  has_one :meta, dependent: :destroy

  validates :path, presence: true
end
