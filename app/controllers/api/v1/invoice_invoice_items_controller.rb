class Api::V1::InvoiceInvoiceItemsController < ApplicationController

  def show
    invoice = Invoice.find(params[:id])
    render json: invoice.invoice_items
  end

end
