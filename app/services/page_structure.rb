require 'nokogiri'

class Services::PageStructure
  class << self
    def call(page)
      @page = page
      parse_page
    end

    private

    def parse_page
      @html = Nokogiri::HTML(@page.contents)

      title = @html.css('//title/text()')
      favicon_path = @html.css("//link[@rel='shortcut icon']/@href")
      @page.update(title: title, favicon_path: favicon_path)

      parse_meta
      parse_htags
      parse_images
      parse_links
    end

    def parse_meta
      encoding = @html.css('//meta/@charset')
      keywords = @html.css("//meta[@name='keywords']/@content")
      author = @html.css("//meta[@name='author']/@content")
      description = @html.css("//meta[@name='description']/@content")

      # build_meta вместо meta.create
      # https://stackoverflow.com/questions/9170245/undefined-method-new-for-nilnilclass-whats-wrong-with-has-one-nested-assoc
      meta = @page.build_meta(encoding: encoding,
                             keywords: keywords,
                             author: author,
                             description: description)
      meta.save
    end

    def parse_htags
      (1..6).each do |i|
        htags_level = @html.css("//h#{i}")
        text = @html.css("//h#{i}/text()")
        htags_level.zip(text).each do |level, contents|
          htag = @page.htags.create(level: level, contents: contents)
        end
      end
    end

    def parse_images
      @html.css("//img").each do |img|
        image = @page.images.create(src: img.css("/@src"), alt: img.css("/@alt"))
      end
    end

    def parse_links
      @html.css("//a").each do |link|
        href = link.css("/@href")
        anchor = link.css("/text()")
        internal = internal_link?(href)

        link = @page.links.create(anchor: anchor, url: href, internal: internal)
      end
    end

    def internal_link?(href)
      return true if href[0] == '/' || href.to_s.start_with?(@page.website.url)
    end
  end
end
