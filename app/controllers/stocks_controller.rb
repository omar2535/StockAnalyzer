#to get params from form, use params[:field].inspect
#

class StocksController < ApplicationController
    def new
    end

    def create
      scraper = StocksHelper::StockScraper.new(stock_search_params[:stockTicker])

      render 'stocks/stockinfo', locals: {resource: scraper.scrape, name: stock_search_params[:stockTicker]}

    end

    def index

    end


  private
    def stock_search_params
      params.require(:stock).permit(:stockTicker)
    end
end
