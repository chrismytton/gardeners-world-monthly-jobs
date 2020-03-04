require 'date'
require 'nokogiri'
require 'net/http'
require 'json'

urls = (1..12).map do |month_number|
  month = Date::MONTHNAMES[month_number]
  [month, "https://www.gardenersworld.com/what-to-do-now-#{month.downcase}/"]
end

out = {}

urls.each do |month, url|
  warn "Fetching: #{url}"
  uri = URI(url)

  Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
    request = Net::HTTP::Get.new uri
    response = http.request request # Net::HTTPResponse object
    page = Nokogiri::HTML(response.body)
    out[month] ||= {}
    page.css('.container > .editor-content').drop(2).take(4).flat_map do |checklist|
      section = checklist.css('h4').text.strip
      tasks = checklist.css('li').map(&:text).map(&:strip)
      out[month][section] = tasks
    end
  end
end

puts JSON.pretty_generate(out)
