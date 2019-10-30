require 'open-uri'

class Services::PageDownloader
  def self.call(url)
    open(url).read
  end
end
