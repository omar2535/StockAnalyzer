require 'nokogiri'
require 'open-uri'
require 'openssl'
#To prevent openssl errors
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


module StocksHelper

  class StockScraper
    attr_reader :stockTicker
    def initialize(stockName)
      puts "Stock name to search for is: " + stockName
      @stockTicker = stockName
      scrape
    end

    #top caller of scraping all data
    #will return all scraped data and perform assesment
    def scrape()
      scrapeForIncomeStatement
    end

    private
      #to scrape for current intraday data
      def scrapeForCurrentData()
        url = "https://ca.finance.yahoo.com/quote/" + @stockTicker + "/key-statistics?"
        result = {}
        #puts url
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

    # scrape for annual income statement
    # reurns array of income statement objects
    def scrapeForIncomeStatement()
      result = [[]]
      url = "https://ca.finance.yahoo.com/quote/" + @stockTicker + "/financials?p="+ @stockTicker;
      page = Nokogiri::HTML(open(url))
      table = page.at('table')
      rows = table.css('tr')
      rows.each_with_index do |row, row_index|
        row = row.css('td')
        temp_arr = []
        row.each_with_index do |data, data_index|
          temp_arr.push(data.text)
        end
        result.push(temp_arr)
      end
      result.delete_at(0)
      final_result = []
      number_of_columns = result[0].length
      for i in 0..number_of_columns-1 do
        column_data = {}
        result.each do |data|
          column_data[data[0]] = data[i]
        end
        final_result.push(column_data)
      end
      #puts final_result
      return final_result
    end




    def scrapeForBalanceSheet()

    end

    def scrapeForCashFlow()

    end




  end


end
