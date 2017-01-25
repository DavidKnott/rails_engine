class Api::V1::TransactionInvoicesController < ApplicationController
  def show
    render json: Transaction.find(params[:transaction_id]).invoice
  end
end