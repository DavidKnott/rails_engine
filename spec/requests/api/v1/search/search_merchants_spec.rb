require 'rails_helper'

describe "Merchant Search Api" do
  it "returns a single merchant matching the given atrribute" do
    create(:merchant, name: "John")
    create_list(:merchant, 10, name: "Doe")

    get "/api/v1/merchants/find?name=john"

    merchant = JSON.parse(response.body)
    expected_name = Merchant.find_by(name:"John").name
    
    expect(response).to be_success
    expect(merchant).to have_key "id"
    expect(merchant).to have_key "name"
    expect(merchant["name"]).to eq expected_name
    expect(merchant).to have_key "created_at"
    expect(merchant).to have_key "updated_at"
  end
end