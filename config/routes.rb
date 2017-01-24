Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get "/merchants/find", to: "finds_merchants#show"
      get "/merchants/find_all", to: "finds_merchants#index"
      resources :merchants, only: [:index, :show]
      get "/customers/find", to: "finds_customers#show"
      get "/customers/find_all", to: "finds_customers#index"
      resources :customers, only: [:index, :show]
      get "/transactions/find", to: "finds_transactions#show"
      get "/transactions/find_all", to: "finds_transactions#index"
      resources :transactions, only: [:index, :show]
    end
  end
end
