require 'nokogiri'
require 'open-uri'
require 'pry'

def getPage
    page = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
    puts 'Page récupéré'
    return page
end

def getSymbols(page)
    crypto_names_array = []
    symbols = page.xpath('/html/body/div/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]')
    for symbol in symbols do
        crypto_names_array.push(symbol.css('div').text)
    end
    return crypto_names_array
end

def getPrices(page)
    crypto_prices_array = []
    prices = page.xpath('/html/body/div/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]')
    for price in prices do
        crypto_prices_array.push(price.css('a').text)
        puts price
    end
    return crypto_prices_array
end

def toMap(crypto_names_array, crypto_prices_array)
    result = Hash.new
    for name in crypto_names_array do
        for price in crypto_prices_array do
            result[name] = price
        end
    end
    return result
end

def perform
    puts 'Initialisation du programme'
    page = getPage
    symbols = getSymbols(page)
    prices = getPrices(page)
    result = toMap(symbols, prices)
    return result
end

perform
