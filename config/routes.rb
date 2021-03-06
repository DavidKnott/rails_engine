Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :merchants do
        get "/random", to: "random_merchants#show"
        get "/find", to: "finds_merchants#show"
        get "/find_all", to: "finds_merchants#index"
        get "/most_items", to: "most_items#index"
        get "/:merchant_id/customers_with_pending_invoices", to: "customers_with_pending_invoices#index"
        get "/most_revenue", to: "top_merchants_by_revenue#index"
        get "/revenue", to: "all_merchants_revenue_on_date#show"
        get "/:merchant_id/favorite_customer", to: "top_customer_for_merchant#show"
      end
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], :controller => "merchants/merchant_items"
        resources :invoices, only: [:index], :controller => "merchants/merchant_invoices"
        resource :revenue, only: [:show], :controller => "merchants/merchant_revenue"
      end
      namespace :customers do
        get "/random", to: "random_customers#show"
        get "/find", to: "finds_customers#show"
        get "/find_all", to: "finds_customers#index"
        get "/:customer_id/favorite_merchant", to: "favorite_merchant#show"
      end
      resources :customers, only: [:index, :show] do
        resources :invoices, only: [:index], :controller => "customers/customer_invoices"
        resources :transactions, only: [:index], :controller => "customers/customer_transactions"
      end
      namespace :items do
        get "/random", to: "random_items#show"
        get "/find", to: "finds_items#show"
        get "/find_all", to: "finds_items#index"
        get "/most_items", to: "most_items#index"
        get "/most_revenue", to: "top_items_by_revenue#index"
        get "/:item_id/best_day", to: "best_day#show"
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
      resources :invoice_items, only: [:index, :show] do
        resource :item, only: [:show], :controller => "invoice_items/invoice_item_item"
        resource :invoice, only: [:show], :controller => "invoice_items/invoice_item_invoice"
      end

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
