require 'rails_helper'

describe "Finds Merchants  Api" do
  it "returns a single merchant matching the given attribute" do
    create(:merchant, name: "John")
    create_list(:merchant, 10)

    get "/api/v1/merchants/find?name=john"

    merchant = JSON.parse(response.body)
    expected_name = Merchant.find_by(name:"John").name
    
    expect(response).to be_success
    expect(merchant).to have_key "id"
    expect(merchant).to have_key "name"
    expect(merchant["name"]).to eq expected_name
  end

  it "returns all merchants matching the given attribute" do
    create_list(:merchant, 6, name: "John")
    create_list(:merchant, 10, name: "Doe")

    get "/api/v1/merchants/find_all?name=john"

    merchants = JSON.parse(response.body)
    merchant = merchants.first
    expected_name = Merchant.find_by(name: "John").name

    expect(response).to be_success
    expect(merchants.count).to eq 6
    expect(merchant).to have_key "id"
    expect(merchant).to have_key "name"
    expect(merchant["name"]).to eq expected_name
  end
end