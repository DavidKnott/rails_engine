Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get "/merchants/random", to: "random_merchants#show"
      get "/merchants/find", to: "finds_merchants#show"
      get "/merchants/find_all", to: "finds_merchants#index"
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
      end

      get "/customers/random", to: "random_customers#show"
      get "/customers/find", to: "finds_customers#show"
      get "/customers/find_all", to: "finds_customers#index"
      resources :customers, only: [:index, :show]

      get "/items/random", to: "random_items#show"
      get "/items/find", to: "finds_items#show"
      get "/items/find_all", to: "finds_items#index"
      resources :items, only: [:index, :show]

      get "/invoices/:id/transactions", to: "invoice_transactions#show"
      get "/invoices/:id/invoice_items", to: "invoice_invoice_items#show"
      get "/invoices/:id/items", to: "invoices_items#show"
      get "/invoices/random", to: "random_invoices#show"
      get "/invoices/find", to: "finds_invoices#show"
      get "/invoices/find_all", to: "finds_invoices#index"
      resources :invoices, only: [:index, :show]

      get "/invoice_items/random", to: "random_invoice_items#show"
      get "/invoice_items/find", to: "finds_invoice_items#show"
      get "/invoice_items/find_all", to: "finds_invoice_items#index"
      resources :invoice_items, only: [:index, :show]

      get "/transactions/random", to: "random_transactions#show"
      get "/transactions/find", to: "finds_transactions#show"
      get "/transactions/find_all", to: "finds_transactions#index"
      resources :transactions, only: [:index, :show]
    end
  end
end
