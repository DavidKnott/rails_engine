class Api::V1::FindsInvoiceItemsController < ApplicationController

  def show
    render json: InvoiceItem.find_by(invoice_item_params)
  end

  private

  def invoice_item_params
    params.permit(:status, :quantity, :unit_price)
  end

end
