class Api::V1::RandomItemsController < ApplicationController
  def show
    render json: Item.order("RANDOM()").first
  end
end
