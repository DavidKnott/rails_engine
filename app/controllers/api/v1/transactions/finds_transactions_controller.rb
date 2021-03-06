class Api::V1::Transactions::FindsTransactionsController < ApplicationController

  def show
    render json: Transaction.find_by(find_params)
  end

  def index
    render json: Transaction.where(find_params)
  end

  private
  def find_params
    params.permit(:id, :invoice_id, :credit_card_number, :result, :created_at, :updated_at)
  end

end