class Website < ApplicationRecord
  validates :url, presence: true, url: true
  validates :scanned_time, presence: true
end
