require 'nokogiri'
require 'open-uri'
require 'pry'

def get_townhall_email(townhall_url)
    townhall_url[0] = ''
    page = Nokogiri::HTML(open('http://annuaire-des-mairies.com'+townhall_url))
    email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
    return email
end

def get_townhall_url
    cities_array = []
    urls_array = []
    page = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))
    urls = page.css('a.lientxt')
    for url in urls do
        urls_array.push(url.attr('href'))
        cities_array.push(url.text)
    end
    return [cities_array, urls_array]
end

def perform
    emails_map = Hash.new
    urls = get_townhall_url[1]
    cities = get_townhall_url[0]
    urls.each_with_index do |item, index|
        email = get_townhall_email(item)
        emails_map[cities[index]] = email
    end
    return emails_map
end

puts perform