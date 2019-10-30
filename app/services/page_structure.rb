require 'nokogiri'

class Services::PageStructure
  class << self
    def call(page)
      @html = page.contents
    end
  end
end
