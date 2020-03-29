# frozen_string_literal: true

require 'date'
require 'nokogiri'
require 'open-uri'
require 'json'

urls = (1..12).map do |month_number|
  month = Date::MONTHNAMES[month_number]
  [month, "https://www.gardenersworld.com/what-to-do-now-#{month.downcase}/"]
end

out = {}

urls.each do |month, url|
  warn "Fetching: #{url}"
  page = Nokogiri::HTML(URI.open(url).read)
  out[month] ||= {}
  page.css('.container > .editor-content').drop(2).take(4).each do |checklist|
    section = checklist.css('h4').text.strip
    tasks = checklist.css('li').map(&:text).map(&:strip)
    out[month][section] = tasks
  end
end

puts JSON.pretty_generate(out)
