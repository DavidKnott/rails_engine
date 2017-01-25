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
        resources :invoices, only: [:index], :controller => "merchant_invoices"
      end
      namespace :customers do
        get "/random", to: "random_customers#show"
        get "/find", to: "finds_customers#show"
        get "/find_all", to: "finds_customers#index"
      end
      resources :customers, only: [:index, :show] do
        resources :invoices, only: [:index], :controller => "customer_invoices"
        resources :transactions, only: [:index], :controller => "customer_transactions"
      end
      resources :customers, only: [:index, :show]
      get "/items/random", to: "random_items#show"
      get "/items/find", to: "finds_items#show"
      get "/items/find_all", to: "finds_items#index"
      resources :items, only: [:index, :show] do
        resources :invoice_items, only: [:index], :controller => "item_invoice_items"
        resource :merchant, only: [:show], :controller => "item_merchants"
      end
      get "/invoices/random", to: "random_invoices#show"
      get "/invoices/find", to: "finds_invoices#show"
      get "/invoices/find_all", to: "finds_invoices#index"
      resources :invoices, only: [:index, :show]
      get "/invoice_items/random", to: "random_invoice_items#show"
      get "/invoice_items/find", to: "finds_invoice_items#show"
      get "/invoice_items/find_all", to: "finds_invoice_items#index"
      resources :invoice_items, only: [:index, :show]
      namespace :transactions do
        get "/random", to: "random_transactions#show"
        get "/find", to: "finds_transactions#show"
        get "/find_all", to: "finds_transactions#index"
      end
      resources :transactions, only: [:index, :show] do
        resource :invoice, only: [:show], :controller => "transaction_invoices"
      end
    end
  end
end
