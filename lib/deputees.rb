require 'nokogiri'
require 'open-uri'
require 'pry'

def get_email(url)  
    page = Nokogiri::HTML(open('http://www2.assemblee-nationale.fr'+url))
    email = page.xpath('//dl[@class="deputes-liste-attributs"]/dd[4]/ul/li[2]/a').text
    return email
end

def get_names_urls
    firstnames_array = []
    lastnames_array = []
    urls_array = []
    page = Nokogiri::HTML(open('http://www2.assemblee-nationale.fr/deputes/liste/tableau'))
    urls = page.xpath('//table[@class="deputes"]/tbody/tr/td[1]/a')
    for url in urls do
        urls_array.push(url.attr('href'))
        firstnames_array.push(url.text.split(' ')[1])
        lastnames_array.push(url.text.split(' ')[2])
    end
    return [firstnames_array, lastnames_array, urls_array]
end

def perform
    emails_map = []
    names_urls = get_names_urls
    firstnames = names_urls[0]
    lastnames = names_urls[1]
    urls = names_urls[2]
    urls.each_with_index do |item, index|
        depute = Hash.new
        email = get_email(item)
        depute['first_name'] = firstnames[index]
        depute['last_name'] = lastnames[index]
        depute['email'] = email
        emails_map.push(depute)
        puts "Email #{index}/#{urls.length} ajouté"
        break if index >= 10
    end
    return emails_map
end

puts perform