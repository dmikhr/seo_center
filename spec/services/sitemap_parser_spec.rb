require 'rails_helper'

RSpec.describe Services::SitemapParser do

  before { allow_any_instance_of(Website).to receive(:check_website) }

  let(:user) { create(:user) }
  let!(:website) { create(:website, user: user) }

  it 'call sitemap service' do
    expect(Services::SitemapParser).to receive(:call).with(website)
    Services::SitemapParser.call(website)
  end

  it 'parse sitemap' do
    sample_paths = ['about-ttie', 'contacts', 'publications', 'binary']

    Services::SitemapParser.call(website)

    url_matches = []
    sample_paths.each do |path|
      url_matches << website.pages.find_by(path: "#{website.url}/#{path}") ? true : false
    end

    expect(url_matches.any?(false)).to be_falsey
  end
end
