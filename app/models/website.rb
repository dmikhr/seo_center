class Website < ApplicationRecord
  belongs_to :user
  has_many :pages, dependent: :destroy

  validates :url, presence: true, url: true

  after_create :check_website, unless: :skip_callbacks

  private

  def check_website
    CheckWebsiteJob.perform_now(self)
  end
end
