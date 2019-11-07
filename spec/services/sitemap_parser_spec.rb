require 'rails_helper'

RSpec.describe Services::SitemapParser do
  let(:user) { create(:user) }
  let!(:website) { create(:website, url: 'http://ttie.ru', user: user) }
  vcr_options = { :record => :new_episodes }

  it 'call sitemap service', vcr: vcr_options do
    expect(Services::SitemapParser).to receive(:call).with(website)
    Services::SitemapParser.call(website)
  end

  # с использованием vcr sitemap будет загружен 1 раз, затем будет использована локальная копия
  it 'parse sitemap', vcr: vcr_options do
    sample_paths = ['about-ttie', 'contacts', 'publications', 'binary']

    Services::SitemapParser.call(website)

    url_matches = []
    sample_paths.each do |path|
      url_matches << website.pages.find_by(path: "#{website.url}/#{path}") ? true : false
    end

    expect(url_matches.any?(false)).to be_falsey
  end
end
