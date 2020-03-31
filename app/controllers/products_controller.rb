class ProductsController < ApplicationController
    def index
        # modelからデータを渡す
        @array = Product.includes.all
    end

    def show
        @product = Product.find(params[:id])
    end

    def create()
        params = {
          method: "post",
          url: "https://yahoo.jp"
        }
        response = http_method(params)
        "#{response["header"]} : #{response["body"]}"
    end

    private

  def http_method(params)
    {"header" => 200, "body" => "Success!"}
  end
end