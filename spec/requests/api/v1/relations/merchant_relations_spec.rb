require 'rails_helper'

describe "Merchant Relations API" do
  it "returns all items for a given merchant" do
    create_list(:merchant_with_items, 5)

    get "/api/v1/merchants/3/items"
    items = JSON.parse(response.body)
    item = items.first

    expect(response).to be_success
    expect(items.count).to eq 6
    items.each_with_index do |item, i|
      expect(item).to have_key "description"
      expect(item).to have_key "unit_price"
      expect(item["merchant"]["id"]).to eq 3
    end
  end
end