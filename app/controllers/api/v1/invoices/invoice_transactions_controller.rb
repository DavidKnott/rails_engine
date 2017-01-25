class Api::V1::Invoices::InvoiceTransactionsController < ApplicationController

  def index
    invoice = Invoice.find(params[:invoice_id])
    render json: invoice.transactions
  end

end
