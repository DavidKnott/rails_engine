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
end