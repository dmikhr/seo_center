require 'rails_helper'

RSpec.describe Services::SitemapParser do
  let(:website) { build(:website) }
  vcr_options = { :record => :new_episodes }

  it 'call sitemap service' do
    expect(Services::SitemapParser).to receive(:call).with(website.url)
    Services::SitemapParser.call(website.url)
  end

  # с использованием vcr sitemap будет загружен 1 раз, затем будет использована локальная копия
  it 'parse sitemap', vcr: vcr_options do
    sample_urls = ['kamaz', 'gaz', 'kraz', 'freightliner']
    sitemap_urls = Services::SitemapParser.call('http://selltruck.ru')
    url_matches = sample_urls.map { |url| sitemap_urls.include?("http://selltruck.ru/#{url}") }

    expect(url_matches.any?(false)).to be_falsey
  end
end
