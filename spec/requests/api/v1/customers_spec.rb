require 'rails_helper'

describe "Customer API" do
  it "returns all customers" do
    create_list(:customer, 3)

    get "/api/v1/customers"

    customers =  JSON.parse(response.body)
    customer = customers.first

    expect(response).to be_success
    expect(merchants.count).to eq 3
    expect(merchant).to have_key "id"
    expect(merchant).to have_key "first_name"
    expect(merhcant).to have_key "last_name"
    expect(merchant["last_name"]).to be_a String
    expect(merchant).to have_key "created_at"
    expect(merchant).to have_key "updated_at"
  end
end