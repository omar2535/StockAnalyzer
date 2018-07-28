require 'nokogiri'
require 'open-uri'
require 'openssl'
#To prevent openssl errors
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


module StocksHelper

  class StockScraper
    attr_reader :stockName
    def initialize(stockName)
      puts "Stock name to search for is: " + stockName
      @stockName = stockName
      scrape
    end

    #top caller of scraping all data
    #will return all scraped data and perform assesment
    def scrape()
      scrapeForCurrentData
    end

    private
      #to scrape for current intraday data
      def scrapeForCurrentData()
        url = "https://ca.finance.yahoo.com/quote/" + @stockName + "/key-statistics?"
        result = {}
        puts url
        page = Nokogiri::HTML(open(url))
        main_contents = page.css('tr td')
        main_contents.search('sup').remove
        main_contents.each_with_index do |content, index|
          if index%2 == 0
            result[content.text] = main_contents[index+1].text
          end
        end
        #puts result
        return result
      end





      #scrape for cashflow
      def scrapeForBalanceSheet()

      end
  end


end
