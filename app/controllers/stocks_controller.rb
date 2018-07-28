#to get params from form, use params[:field].inspect
#

class StocksController < ApplicationController
    def new
    end

    def create
      render plain: "stuff"
      scraper = StocksHelper::StockScraper.new(stock_search_params[:stockName])
    end

    def index

    end


  private
    def stock_search_params
      params.require(:stock).permit(:stockName)
    end
end
