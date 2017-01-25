require 'rails_helper'

describe "Customer Relations API" do
  it "returns all invoices for a given customer" do
    customer = create_list(:customer_with_invoices, 3, invoices_count: 4).first

    get "/api/v1/customers/#{customer.id}/invoices"

    invoices = JSON.parse(response.body)
    invoice = invoices.first

    expect(response).to be_success
    expect(invoices.count).to eq 4
    expect(invoice).to have_key "status"
    expect(invoice["customer_id"]).to eq customer.id
  end

  it "returns all transactions for a given customer" do
    customer = create_list(:customer_with_invoices_with_transactions, 3, invoices_count: 2, transactions_count: 2).first

    get "/api/v1/customers/#{customer.id}/transactions"

    transactions = JSON.parse(response.body)
    transaction = transactions.first

    expect(response).to be_success
    expect(transactions.count).to eq 4
    expect(transaction).to have_key "credit_card_number"
    byebug
    expect(transaction).to eq customer.id
  end
end