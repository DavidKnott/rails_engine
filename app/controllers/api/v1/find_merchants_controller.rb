class Api::V1::FindMerchantsController < ApplicationController

  # scope :ci_find, lambda { |attr, val| where("lower(#attr}) =?", value.downcase).first}

  def show
    render json: Merchant.ci_find(find_params)
  end

  private

  def find_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end