Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :merchants do
        get "/random", to: "random_merchants#show"
        get "/find", to: "finds_merchants#show"
        get "/find_all", to: "finds_merchants#index"
      end
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], :controller => "merchants/merchant_items"
        resources :invoices, only: [:index], :controller => "merchants/merchant_invoices"
      end
      namespace :customers do
        get "/random", to: "random_customers#show"
        get "/find", to: "finds_customers#show"
        get "/find_all", to: "finds_customers#index"
      end
      resources :customers, only: [:index, :show] do
        resources :invoices, only: [:index], :controller => "customers/customer_invoices"
        resources :transactions, only: [:index], :controller => "customers/customer_transactions"
      end
      namespace :items do
        get "/random", to: "random_items#show"
        get "/find", to: "finds_items#show"
        get "/find_all", to: "finds_items#index"
      end
      resources :items, only: [:index, :show] do
        resources :invoice_items, only: [:index], :controller => "items/item_invoice_items"
        resource :merchant, only: [:show], :controller => "items/item_merchants"
      end

      namespace :invoices do
        get "/random", to: "random_invoices#show"
        get "/find", to: "finds_invoices#show"
        get "/find_all", to: "finds_invoices#index"
      end
      resources :invoices, only: [:index, :show] do
        resources :transactions, only: [:index], :controller => "invoices/invoice_transactions"
        resources :invoice_items, only: [:index], :controller => "invoices/invoice_invoice_items"
        resources :items, only: [:index], :controller => "invoices/invoice_items"
        resource :customer, only: [:show], :controller => "invoices/invoice_customer"
        resource :merchant, only: [:show], :controller => "invoices/invoice_merchant"
      end

      namespace :invoice_items do
        get "/random", to: "random_invoice_items#show"
        get "/find", to: "finds_invoice_items#show"
        get "/find_all", to: "finds_invoice_items#index"
      end
      resources :invoice_items, only: [:index, :show]

      namespace :transactions do
        get "/random", to: "random_transactions#show"
        get "/find", to: "finds_transactions#show"
        get "/find_all", to: "finds_transactions#index"
      end
      resources :transactions, only: [:index, :show] do
        resource :invoice, only: [:show], :controller => "transactions/transaction_invoices"
      end
    end
  end
end
