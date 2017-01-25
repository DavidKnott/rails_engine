require 'rails_helper'

describe "Transaction Relations API" do
  it "returns all invoices for a given merchant" do
    transaction = create_list(:invoice_with_transactions, 3, transactions_count: 4).first.transactions.first

    get "/api/v1/transactions/#{transaction.id}/invoices"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice).to be_a Hash
    expect(invoice).to have_key "unit_price"
    expect(invoice["transaction"]["id"]).to eq transaction.id
  end
end