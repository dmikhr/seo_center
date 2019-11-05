class Website < ApplicationRecord

  has_many :pages, dependent: :destroy

  validates :url, presence: true, url: true

  after_create :check_website

  private

  def check_website
    CheckWebsiteJob.perform_now(self)
  end
end
