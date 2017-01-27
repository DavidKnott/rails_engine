class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  def show
    render json: Merchant.favorite(params[:customer_id])
  end
end