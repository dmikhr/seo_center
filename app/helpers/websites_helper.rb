module WebsitesHelper
  def boolean_to_readable(value)
    value ? "exists" : "none"
  end

  def website_versions
    if current_user.admin?
      Website.where(url: @website.url).order(scanned_time: :desc)
    else
      Website.where(user: current_user, url: @website.url).order(scanned_time: :desc)
    end
  end
end
