require 'rails_helper'

describe "Merchants API" do
  it "returns a list of all merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    expect(repsonse).to be_success
    expect(merchants.count).to eq 3
    expect(merchant).to be_a Hash
    expect(merchant).to have_key "id"
    expect(merchant).to have_key "name"
    expect(merchant["name"]).to be_a String
    expect(merchant).to have_key "created_at"
    expect(merchant).to have_key "updated_ay"
  end
end