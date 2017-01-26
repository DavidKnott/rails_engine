require 'rails_helper'

describe "Item Business Intelligence" do
  it "returns the items ranked by total number sold" do
    merchant = create_list(:merchant_with_invoices, 1, invoices_count: 1).first
    customer = create(:customer)
    invoice = merchant.invoices.create(status: "limbo", customer_id: customer.id)
    create_list(:transaction, 2, result: "success", invoice_id: invoice.id)
    create_list(:transaction, 2, result: "success", invoice_id: invoice.id)
    create_list(:transaction, 2, result: "success", invoice_id: invoice.id)
    items = create_list(:item, 3)
    create(:invoice_item, item_id: items[0].id, invoice_id: invoice.id, unit_price:100, quantity:2)
    create(:invoice_item, item_id: items[1].id, invoice_id: invoice.id, unit_price:100, quantity:2)
    create(:invoice_item, item_id: items[2].id, invoice_id: invoice.id, unit_price:100, quantity:2)
    

    get "/api/v1/items/most_items?quantity=3"

    items = JSON.parse(response.body)
    item_json = items.first

    expect(response).to be_success
    expect(items.count).to eq 3
    expect(item_json["id"]).to eq 1

    # Item
    # # Item.unscoped.joins(:invoice_items, :invoices).joins(invoices: [:transactions]).where(transactions: {result:"success"}).group(:id).select("items.id, SUM(invoice_items.quantity) as quant").order("quant desc").limit(3)
    # # GET /api/v1/items/most_items?quantity=x 
  end
end