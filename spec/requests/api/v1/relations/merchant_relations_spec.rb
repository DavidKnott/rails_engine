require 'rails_helper'

describe "Merchant Relations API" do
  it "returns all items for a given merchant" do
    merchant = create_list(:merchant_with_items, 3, items_count: 3).first

    get "/api/v1/merchants/#{merchant.id}/items"
    items = JSON.parse(response.body)
    item = items.first

    expect(response).to be_success
    expect(items.count).to eq 3
    items.each do |item|
      expect(item).to have_key "description"
      expect(item).to have_key "unit_price"
      expect(item["merchant_id"]).to eq merchant.id
    end
  end

  it "returns all invoices for a given merchant" do
    merchant = create_list(:merchant_with_invoices, 3, invoices_count: 2).first
    
    get "/api/v1/merchants/#{merchant.id}/invoices"

    invoices = JSON.parse(response.body)
    expect(response).to be_success
    expect(invoices.count).to eq 2
    invoices.each do |invoice|
      expect(invoice).to have_key "status"
      expect(invoice["merchant_id"]).to eq merchant.id
    end
  end
end