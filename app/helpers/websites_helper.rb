module WebsitesHelper
  def boolean_to_readable(value)
    value ? "exists" : "none"
  end
end
