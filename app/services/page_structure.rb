require 'nokogiri'

class Services::PageStructure
  class << self
    def call(page)
      @page = page
      parse_page
    end

    private

    def parse_page
      html = Nokogiri::HTML(@page.contents)

      title = html.css('//title/text()')
      favicon_path = html.css("//link[@rel='shortcut icon']/@href")

      # meta
      encoding = html.css('//meta/@charset')
      keywords = html.css("//meta[@name='keywords']/@content")
      author = html.css("//meta[@name='author']/@content")
      description = html.css("//meta[@name='description']/@content")

      # FIX: undefined method `metas' for #<Page:0x00007fbbd1e3fe10>
      # meta = @page.metas.new(encoding: encoding,
      #                        keywords: keywords,
      #                        author: author,
      #                        description: description)
      # meta.save

      # h tags
      (1..6).each do |i|
        htags_level = html.css("//h#{i}")
        text = html.css("//h#{i}/text()")
        htags_level.zip(text).each do |level, contents|
          htag = @page.htags.new(level: level, contents: contents)
          htag.save
        end
      end

      # img
      html.css("//img").each do |img|
        image = @page.images.new(src: img.css("/@src"), alt: img.css("/@alt"))
        image.save
      end

      # links
      html.css("//a").each do |link|
        href = link.css("/@href")
        anchor = link.css("/text()")
        internal = internal_link?(href)

        link = @page.links.new(anchor: anchor, url: href, internal: internal)
        link.save
      end
    end

    def internal_link?(href)
      return true if href[0] == '/' || href.to_s.start_with?(@page.website.url)
    end
  end
end
