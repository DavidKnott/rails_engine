class Api::V1::Merchants::TopMerchantsByRevenueController < ApplicationController
  def index
  	merchants = Merchant.all
  	render json: merchants.most_revenue(top_x)
  end

  def top_x
    return params[:quantity] if params[:quantity]
    1
  end
end
