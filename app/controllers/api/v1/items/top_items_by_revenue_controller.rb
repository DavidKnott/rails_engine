class Api::V1::Items::TopItemsByRevenueController < ApplicationController
  def index
  	items = Item.all
  	render json: items.most_revenue(top_x)
  end

  def top_x
    return params[:quantity] if params[:quantity]
    1
  end
end
