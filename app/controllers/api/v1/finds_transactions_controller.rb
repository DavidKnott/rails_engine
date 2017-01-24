class Api::V1::FindsTransactionsController < ApplicationController

  def show
    render json: Transaction.where(find_params).first
  end


  private
  def find_params
    params.permit(:credit_card_number, :result, :created_at, :updated_at)
  end

end