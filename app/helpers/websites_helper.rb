module WebsitesHelper
  def boolean_to_readable(value)
    value ? "exists" : "none"
  end

  def website_versions
    Website.where(user: current_user, url: @website.url).order(scanned_time: :desc)
  end
end
