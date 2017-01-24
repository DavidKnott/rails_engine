require 'rails_helper'

describe "Finds Customers API" do
  it "returns a single customer matching the given attribute" do
    create(:customer, last_name: "King")
    create_list(:customer, 10)

    get "/api/v1/customers/find?last_name=king"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer).to have_key "id"
    expect(customer).to have_key "first_name"
    expect(customer).to have_key "last_name"
    expect(customer["last_name"]).to eq expected_name
    expect(customer).to have_key "created_at"
    expect(customer).to have_key "updated_at"
  end
end