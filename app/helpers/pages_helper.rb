module PagesHelper
  def link_type(value)
    value ? "internal" : "external"
  end

  def links_internal
    @page.links.count(&:internal?)
  end

  def links_external
    @page.links.count(&:external?)
  end

  def htags_stats
    levels = @page.htags.select(:level).distinct.map { |item| item.level }
    amounts = levels.map { |level| @page.htags.count { |htag| htag.level == level } }
    htags_amount = levels.zip(amounts).map { |level, amount| "h#{level}: #{amount}" }
    "Total: #{@page.htags.size} (#{htags_amount.join(', ')})" if htags_amount.size > 0
  end
end
