module PagesHelper
  def show_item(caption, item)
    "#{caption}: #{item}" if item.present?
  end

  def link_type(value)
    value ? "internal" : "outbound"
  end

  def links_stats
    internal_num = @page.links.select { |link| link.internal == true }.size
    outbound_num = @page.links.select { |link| link.internal == false }.size
    "Internal: #{internal_num} | Outbound: #{outbound_num}"
  end

  def htags_stats
    levels = @page.htags.select(:level).distinct.map { |item| item.level }
    amounts = levels.map { |level| @page.htags.select { |htag| htag.level == level }.size }
    htags_amount = levels.zip(amounts).map { |level, amount| "h#{level}: #{amount}" }
    "Total: #{@page.htags.size} | #{htags_amount.join(', ')}"
  end
end
