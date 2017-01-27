class Api::V1::InvoiceItems::FindsInvoiceItemsController < ApplicationController

  def index
    adjusted_item_params = dollars_to_cents
    render json: InvoiceItem.where(adjusted_item_params)
  end

  def show
    adjusted_item_params = dollars_to_cents
    render json: InvoiceItem.find_by(adjusted_item_params)
  end

  private

  def invoice_item_params
    params.permit(:id, :status, :quantity, :unit_price, :invoice_id, :item_id, :updated_at, :created_at)
  end

  def dollars_to_cents
    if invoice_item_params["unit_price"]
      return {"unit_price" => (invoice_item_params["unit_price"].to_f * 100).round(0)}
    end
    invoice_item_params
  end

end
