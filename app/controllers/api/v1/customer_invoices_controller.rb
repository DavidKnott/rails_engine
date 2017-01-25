class Api::V1::CustomerInvoicesController < ApplicationController
  def index
    render json: Customer.find(params[:customer_id]).invoices
  end
end