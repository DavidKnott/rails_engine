class Api::V1::RandomCustomersController < ApplicationController
  def show
    render json: Customer.order("RANDOM()").first
  end
end