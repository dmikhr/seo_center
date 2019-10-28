require 'net/http'
require 'net/https'

class Services::CheckWebsite
  class << self
    def call(website)
      uri = URI(website.url)
      # проверяем существование URL
      return unless response_success?(uri)
      www = www?(uri)
      https = https?(uri)
      # scanned_time для хранения разных версий одного сайта
      website.update!(www: www, https: https, scanned_time: DateTime.now)
    end

    private

    def www?(uri)
      # если домен уже был задан с www
      return true if uri.host[0, 4] == 'www.'
      # иначе проверяем существование www
      domain_with_www = URI("#{uri.scheme}://www.#{uri.host}")
      response_success?(domain_with_www)
    end

    def https?(uri)
      return unless uri.scheme == 'https'
      # Net::HTTP by Example / Net::HTTP Cheat Sheet: https://yukimotopress.github.io/http
      http = Net::HTTP.new(uri.host, uri.port)

      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER

      response = http.request(Net::HTTP::Get.new("/"))
      response.is_a?(Net::HTTPSuccess)
    end

    def response_success?(uri)
      res = Net::HTTP.get_response(uri)
      res.is_a?(Net::HTTPSuccess)
    end
  end
end
