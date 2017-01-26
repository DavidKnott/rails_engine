require 'rails_helper'

describe "Finds Customers API" do
  it "returns a single customer matching the given attribute" do
    create(:customer, last_name: "King")
    create_list(:customer, 10)

    get "/api/v1/customers/find?last_name=king"

    customer = JSON.parse(response.body)
    expected_last_name = Customer.find_by(last_name: "King").last_name

    expect(response).to be_success
    expect(customer).to have_key "id"
    expect(customer).to have_key "first_name"
    expect(customer).to have_key "last_name"
    expect(customer["last_name"]).to eq expected_last_name
  end

  it "returns all customers matching the given attribute" do
    create_list(:customer, 6, last_name: "King")
    create_list(:customer, 10, last_name: "Doe")

    get "/api/v1/customers/find_all?last_name=king"

    customers = JSON.parse(response.body)
    customer = customers.first
    expected_last_name = Customer.find_by(last_name: "King").last_name

    expect(response).to be_success
    expect(customers.count).to eq 6
    expect(customer).to have_key "id"
    expect(customer).to have_key "first_name"
    expect(customer).to have_key "last_name"
    expect(customer["last_name"]).to eq expected_last_name
  end
end