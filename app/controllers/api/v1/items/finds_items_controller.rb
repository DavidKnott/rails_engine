class Api::V1::Items::FindsItemsController < ApplicationController

  def index
    render json: Item.order(:id).where(item_params)
  end

  def show
    render json: Item.order(:id).find_by(item_params)
  end

  private

  def item_params
    dollars_to_cents
    params.permit(:id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id)
  end

end
