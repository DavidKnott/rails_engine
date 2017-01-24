require 'rails_helper'

describe "Customer API" do
  it "returns all customers" do
    create_list(:customer, 3)

    get "/api/v1/customers"

    customers =  JSON.parse(response.body)
    customer = customers.first

    expect(response).to be_success
    expect(customers.count).to eq 3
    expect(customer).to have_key "id"
    expect(customer).to have_key "first_name"
    expect(customer).to have_key "last_name"
    expect(customer["last_name"]).to be_a String
    expect(customer).to have_key "created_at"
    expect(customer).to have_key "updated_at"
  end

  it "returns a single merchant" do
    create_list(:customer, 3)

    get "/api/v1/customers/2"

    customer = JSON.parse(response.body)
    expected_last_name = Customer.find(2).last_name

    expect(response).to be_success
    expect(customer).to have_key "id"
    expect(customer).to have_key "first_name"
    expect(customer).to have_key "last_name"
    expect(customer["last_name"]).to eq expected_last_name
    expect(customer).to have_key "created_at"
    expect(customer).to have_key "updated_at"

  end
end