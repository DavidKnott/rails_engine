require 'rails_helper'

describe "Merchant Relations API" do
  xit "returns all items for a given merchant" do
    create_list(:merchant_with_items, 12)

    get "/api/v1/merchants/3/items"

    expect(response).to be_success
    expect(items.count).to eq 6
    expect(item).to have_key "id"
    expect(item).to have_key "name"
    expect(item).to have_key "created_at"
    expect(item).to have_key "updated_at"
    expect(item["merchant"]).to eq 3
  end
end