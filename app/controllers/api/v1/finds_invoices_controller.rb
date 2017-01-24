class Api::V1::FindsInvoicesController < ApplicationController

  def show
    render json: Invoice.find_by(invoice_params)
  end

  private

  def invoice_params
    params.permit(:status)
  end

end
