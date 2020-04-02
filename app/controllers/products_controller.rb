class ProductsController < ApplicationController
    def index
        # modelからデータを渡す
        @array = Product.includes.all
    end

    def show
        @product = Product.find(params[:id])
    end
end