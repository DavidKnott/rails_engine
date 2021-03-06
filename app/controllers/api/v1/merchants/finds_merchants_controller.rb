class Api::V1::Merchants::FindsMerchantsController < ApplicationController

  def show
    render json: Merchant.find_by(find_params)
  end

  def index
    render json: Merchant.where(find_params)
  end

  private

  def find_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end