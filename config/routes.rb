Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get "/merchants/find?parameters", to: "find_merchants#show"
      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]
    end
  end
end
