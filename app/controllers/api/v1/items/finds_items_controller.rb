class Api::V1::Items::FindsItemsController < ApplicationController

  def index
    render json: Item.where(item_params)
  end

  def show
    adjusted_item_params = dollars_to_cents
    render json: Item.find_by(adjusted_item_params)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :created_at, :updated_at)
  end

  def dollars_to_cents
    return {"unit_price" => (item_params["unit_price"].to_f * 100).round(0)} if item_params["unit_price"]
    item_params
  end

end
