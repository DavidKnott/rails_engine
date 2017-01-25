class Api::V1::InvoicesItemsController < ApplicationController

  def show
    invoice = Invoice.find(params[:id])
    render json: invoice.items
  end

end
