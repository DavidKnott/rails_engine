class Api::V1::MerchantsController < ApplicationController

  def index
    render json: Merchant.all
  end

  def show
    byebug
    render json: Merchant.find(params[:id])
  end
end