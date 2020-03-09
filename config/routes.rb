Rails.application.routes.draw do
  post "/piyo", to: "piyo#index"

  # routingの設定
  # get "/users", to: "users#index"
  # post "/users", to: "users#create"
  # patch "/users", to: "users#update"
  # delete "/users", to: "users#destroy"
  # get "/users", to: "users#show"

  # # resourcesの設定
  # resources :users, except: [:new, :edit]
  resources :products, only: [:index, :show]

  # ネストの設定
  resources :users, except: [:new, :edit] do
    resources :articles do
    end
  end
end