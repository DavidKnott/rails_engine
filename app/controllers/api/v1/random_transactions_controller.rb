class Api::V1::RandomTransactionsController < ApplicationController
  def show
    render json: Transaction.order("RANDOM()").first
  end
end