Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :merchants do
        get "/random", to: "random_merchants#show"
        get "/find", to: "finds_merchants#show"
        get "/find_all", to: "finds_merchants#index"
      end
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], :controller => "merchant_items"
      end
      namespace :customers do
        get "/random", to: "random_customers#show"
        get "/find", to: "finds_customers#show"
        get "/find_all", to: "finds_customers#index"
      end
      resources :customers, only: [:index, :show]
      namespace :transactions do
        get "/random", to: "random_transactions#show"
        get "/find", to: "finds_transactions#show"
        get "/find_all", to: "finds_transactions#index"
      end
      resources :transactions, only: [:index, :show]
      get "/items/find", to: "finds_items#show"
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
    end
  end
end
