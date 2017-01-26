require 'rails_helper'

describe "Transactions API" do
  it "returns a list of all transactions" do
    create_list(:transaction, 3)

    get "/api/v1/transactions"

    transactions = JSON.parse(response.body)
    transaction = transactions.first

    expect(response).to be_success
    expect(transactions.count).to eq 3
    expect(transaction).to have_key "credit_card_number"
    expect(transaction).to have_key "result"
    expect(transaction["result"]).to be_a String
    expect(transaction).to have_key "invoice_id"
  end
  
  it "returns a single transaction" do
    create_list(:transaction, 3)

    get "/api/v1/transactions/2"

    transaction = JSON.parse(response.body)
    expected_card_number = Transaction.find(2).credit_card_number

    expect(response).to be_success
    expect(transaction).to have_key "credit_card_number"
    expect(transaction["credit_card_number"]).to eq expected_card_number
    expect(transaction).to have_key "result"
    expect(transaction).to have_key "invoice_id"
  end
end