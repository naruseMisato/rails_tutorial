class ProductsController < ApplicationController
    def index
        @value = "PIYO!"
    end

    def show
        @item = {
            id: "5e664f52e513688cd0651dce",
            name: "iPhoneX 10000円",
        }
        @user = {
            id: "misato.naruse@jmty.jp",
            name: "ちゃんなる"
        }
    end
end