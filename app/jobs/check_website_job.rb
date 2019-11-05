class CheckWebsiteJob < ApplicationJob
  queue_as :default

  def perform(website)
    Services::CheckWebsite.call(website)
  end
end
