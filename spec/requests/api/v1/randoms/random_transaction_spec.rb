require 'rails_helper'

describe "Random Transaction API" do
  it "returns a random transaction" do
    create_list(:transaction, 20)

    get "/api/v1/transactions/random"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction).to be_a Hash
    expect(transaction).to have_key "id"
    expect(transaction).to have_key "credit_card_number"
    expect(transaction).to have_key "result"
  end
end