class Api::V1::RandomInvoicesController < ApplicationController
  def show
    render json: Invoice.order("RANDOM()").first
  end
end
