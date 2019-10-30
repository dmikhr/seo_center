require 'nokogiri'
require 'open-uri'

class Services::SitemapParser
  def self.call(url)
    sitemap = Nokogiri::XML(open("#{url}/sitemap.xml"))
    sitemap.css('loc').map { |loc| loc.text }
  end
end
