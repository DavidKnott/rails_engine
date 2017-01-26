class Api::V1::Invoices::InvoiceMerchantController < ApplicationController

  def show
    invoice = Invoice.find(params[:invoice_id])
    render json: invoice.merchant
  end

end
