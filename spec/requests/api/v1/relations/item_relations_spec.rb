require 'rails_helper'

describe "Item Relations API" do
  it "returns all invoice_items for a given item" do
    item = create_list(:item_with_invoice_items, 3, invoice_items_count: 4).first

    get "/api/v1/items/#{item.id}/invoice_items"

    invoice_items = JSON.parse(response.body)
    invoice_item = invoice_items.first

    expect(response).to be_success
    expect(invoice_items.count).to eq 4
    expect(invoice_item).to have_key "quantity"
    expect(invoice_item["item_id"]).to eq item.id
  end

  it "returns the merchant for a given item" do
    merchant1 = create_list(:merchant_with_items, 3, items_count: 4).first

    get "/api/v1/#{merchant1.id}/merchant"

    merchant2 = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant2).to be_a Hash
    expect(merchant2).to have_key "name"
    expect(merchant2["id"]).to eq merchant1.id
  end
end