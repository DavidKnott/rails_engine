class Api::V1::Merchants::TopCustomerForMerchantController < ApplicationController

  def show
    render json: Customer.most_successful_transactions(params[:merchant_id])
  end
  
end
