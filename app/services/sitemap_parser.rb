require 'nokogiri'
require 'open-uri'

class Services::SitemapParser
  def self.call(website)
    sitemap = Nokogiri::XML(open("#{website.url}/sitemap.xml"))
    urls = sitemap.css('loc').map { |loc| loc.text }

    urls.each do |url|
      contents = Services::PageDownloader.call(url)
      page = website.pages.new(path: url, contents: contents)
      page.save
    end
  end
end
