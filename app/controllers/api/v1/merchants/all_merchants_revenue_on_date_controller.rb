class Api::V1::Merchants::AllMerchantsRevenueOnDateController < ApplicationController
  def show
  	merchants = Merchant.all
  	render json: merchants.all_merchants_revenue_on_date(params[:date]), serializer: TotalRevenueSerializer
  end
end
