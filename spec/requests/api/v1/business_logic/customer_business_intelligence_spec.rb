require 'rails_helper'

describe "Customer Business Intelligence" do
  it "returns a merchant where the given customer has the most successful transacions" do
    merchant = create_list(:merchant_with_invoices, 1, invoices_count: 1).first
    customer = create(:customer)
    invoice = merchant.invoices.create(status: "limbo", customer_id: customer.id)
    transactions = create_list(:transaction, 2, result: "success", invoice_id: invoice.id)
    item = create_list(:item, 3).first
    create_list(:invoice_item, 1, item_id: item.id, invoice_id: invoice.id, unit_price:100, quantity:2)

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    merchant_json = JSON.parse(response.body)
    merchant_from_json = Merchant.find(merchant_json["id"])
    transactions_with_merchant = merchant_from_json.invoices.joins(:transactions).count

    expect(response).to be_success
    expect(transactions_with_merchant).to eq 2
  end
end