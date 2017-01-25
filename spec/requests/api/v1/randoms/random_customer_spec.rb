require 'rails_helper'

describe "Random Customer API" do
  it "returns a random customer" do
    create_list(:customer, 20)

    get "/api/v1/customers/random"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer).to be_a Hash
    expect(customer).to have_key "first_name"
    expect(customer).to have_key "last_name"
  end
end