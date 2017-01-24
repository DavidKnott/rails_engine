Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get "/merchants/find", to: "finds_merchants#show"
      get "/merchants/find_all", to: "finds_merchants#index"
      resources :merchants, only: [:index, :show]
      get "/customers/find", to: "finds_customers#show"
      resources :customers, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end
