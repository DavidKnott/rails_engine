class Api::V1::InvoiceItems::InvoiceItemInvoiceController < ApplicationController

  def show
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    render json: invoice_item.invoice
  end

end
