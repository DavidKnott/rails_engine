require 'rails_helper'

describe "Transaction Relations API" do
  it "returns the invoice for a given transaction" do
    transaction = create_list(:invoice_with_transactions, 3, transactions_count: 4).first.transactions.first
    merchant = create(:merchant_with_items)
    item = merchant.items.first
    create(:invoice_item, item_id: item.id, invoice_id: transaction.invoice.id)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice).to be_a Hash
    expect(invoice).to have_key "status"
    expect(invoice["id"]).to eq transaction.invoice.id
  end
end