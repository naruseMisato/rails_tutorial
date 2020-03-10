class ProductsController < ApplicationController
    def index
        # 固定データを渡す
        # @array = [
        #     {id: "5e664f52e513688cd0651dce", name: "iPhoneX 10000円", user: {id: "fhud29fkqmo2", name: "naru"}},
        #     {id: "5e664f52e513688cd0651dcf", name: "iPhoneX 20000円", user: {id: "fhud29fkqmo2", name: "naru"}}
        # ]

        # mmodelからデータを渡す
        @array = Product.all
    end

    def show
        @array = [
            {id: "5e664f52e513688cd0651dce", name: "iPhoneX 10000円"},
            {id: "5e664f52e513688cd0651dcf", name: "iPhoneX 20000円"}
        ]
        @user = {
            id: "misato.naruse@jmty.jp",
            name: "ちゃんなる"
        }
    end
end