require 'rails_helper'

describe "Merchant Bussiness Intelligence" do
  it "returns the total revenue for a single merchant" do
    merchant = create_list(:merchant_with_invoices, 3, invoices_count: 3).first
    invoice = merchant.invoices.first
    transactions = create_list(:transaction, 3, result: "sucess", invoice_id: invoice.id)
    item = create_list(:item, 3).first
    create_list(:invoice_item, 3, item_id: item.id, invoice_id: invoice.id, unit_price:100, quantity:2)
    
    get "api/v1/merchants/#{merchant.id}/revenue"
    revenue = JSON.parse(response.body)

    expect(revenue).to eq "6.00"
  end
end