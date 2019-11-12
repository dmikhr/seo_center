class Website < ApplicationRecord
  belongs_to :user
  has_many :pages, dependent: :destroy

  validates :url, presence: true, url: true

  after_create :check_website, unless: :skip_callbacks

  def self.scanned_latest(user)
    websites = []

    if user.admin?
      urls = Website.all.distinct.pluck(:url)
      urls.each { |url| websites << Website.where(url: url).order(scanned_time: :desc).first }
    else
      urls = Website.where(user: user).distinct.pluck(:url)
      urls.each { |url| websites << Website.where(user: user, url: url).order(scanned_time: :desc).first }
    end

    websites
  end

  private

  def check_website
    CheckWebsiteJob.perform_now(self)
  end
end
