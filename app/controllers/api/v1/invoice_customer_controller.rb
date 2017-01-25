class Api::V1::InvoiceCustomerController < ApplicationController

  def show
    invoice = Invoice.find(params[:id])
    render json: invoice.customer
  end

end
