class Api::V1::InvoiceTransactionsController < ApplicationController

  def show
    invoice = Invoice.find(params[:id])
    render json: invoice.transactions
  end

end
