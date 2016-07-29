require 'bundler'
Bundler.require
OpenURI::Cache.cache_path = 'archive'

require 'open-uri'

(1..12).each do |month_number|
  month = Date::MONTHNAMES[month_number]
  url = "http://www.gardenersworld.com/what-to-do-now/checklist/#{month.downcase}/"
  warn "Fetching: #{url}"
  page = Nokogiri::HTML(open(url))
  page.css('.checklist').each do |checklist|
    checklist.css('.checklist__item').each do |job|
      data = {
        month: month_number,
        section: checklist[:id],
        job: job.text.strip
      }
      ScraperWiki.save_sqlite([:month, :section, :job], data)
    end
  end
end
