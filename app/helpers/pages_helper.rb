module PagesHelper
  def link_type(value)
    value ? "internal" : "outbound"
  end

  def links_internal
    @page.links.select { |link| link.internal == true }.size
  end

  def links_outbound
    @page.links.select { |link| link.internal == false }.size
  end

  def htags_stats
    levels = @page.htags.select(:level).distinct.map { |item| item.level }
    amounts = levels.map { |level| @page.htags.select { |htag| htag.level == level }.size }
    htags_amount = levels.zip(amounts).map { |level, amount| "h#{level}: #{amount}" }
    "Total: #{@page.htags.size} | #{htags_amount.join(', ')}"
  end
end
