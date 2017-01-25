class Api::V1::InvoiceMerchantController < ApplicationController

  def show
    invoice = Invoice.find(params[:id])
    render json: invoice.merchant
  end

end
