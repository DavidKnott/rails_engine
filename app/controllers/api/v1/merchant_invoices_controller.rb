require 'rails_helper'

class Api::V1::MerchantInvoicesController < ApplicationController
  def index
    render json: Merchant.find(params[:merchant_id]).items
  end
end