require 'nokogiri'

class Services::PageStructure
  class << self
    def call(page)
      page.contents
    end
  end
end
