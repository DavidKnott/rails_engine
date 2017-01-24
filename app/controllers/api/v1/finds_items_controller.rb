class Api::V1::FindsItemsController < ApplicationController

  def show
    render json: Item.find_by(item_params)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :created_at, :updated_at)
  end

end
