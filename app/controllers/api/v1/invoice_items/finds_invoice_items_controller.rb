class Api::V1::InvoiceItems::FindsInvoiceItemsController < ApplicationController

  def index
    render json: InvoiceItem.where(invoice_item_params)
  end

  def show
    render json: InvoiceItem.find_by(invoice_item_params)
  end

  private

  def invoice_item_params
    dollars_to_cents
    params.permit(:id, :status, :quantity, :unit_price, :invoice_id, :item_id, :updated_at, :created_at)
  end

end
