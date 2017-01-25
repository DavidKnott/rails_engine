class Api::V1::RandomInvoiceItemsController < ApplicationController
  def show
    render json: InvoiceItem.order("RANDOM()").first
  end
end
