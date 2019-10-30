class Page < ApplicationRecord
  belongs_to :website
  has_one :meta, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :htags, dependent: :destroy

  validates :path, presence: true
end
