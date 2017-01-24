require 'rails_helper'

describe "Random Merchant API" do
  it "returns a random merchant" do
    create_list(:merchant, 20)

    get "/api/v1/merchants/random"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant).to be_a Hash
    expect(merchant).to have_key "id"
    expect(merchant).to have_key "name"
    expect(merchant).to have_key "create_at"
    expect(merchant).to have_key "updated_ay"
  end
end