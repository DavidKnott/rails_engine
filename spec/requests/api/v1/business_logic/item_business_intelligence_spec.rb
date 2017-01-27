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
  end

  it "returns they date where a given item had the most sales" do
    time1 = "2012-03-27T14:54:05.000Z"
    time2 = "2012-03-26T14:54:05.000Z"
    time3 = "2012-03-25T14:54:05.000Z"
    merchant = create_list(:merchant_with_invoices, 1, invoices_count: 1).first
    customer = create(:customer)
    invoice1 = merchant.invoices.create(status: "limbo", customer_id: customer.id, created_at: time1)
    invoice2 = merchant.invoices.create(status: "limbo", customer_id: customer.id, created_at: time2)
    invoice3 = merchant.invoices.create(status: "limbo", customer_id: customer.id, created_at: time3)
    create_list(:transaction, 2, result: "success", invoice_id: invoice1.id)
    create_list(:transaction, 2, result: "success", invoice_id: invoice2.id)
    create_list(:transaction, 2, result: "success", invoice_id: invoice3.id)
    items = create_list(:item, 3)
    create(:invoice_item, item_id: items[0].id, invoice_id: invoice1.id, unit_price:100, quantity:30)
    create(:invoice_item, item_id: items[0].id, invoice_id: invoice2.id, unit_price:100, quantity:2)
    create(:invoice_item, item_id: items[1].id, invoice_id: invoice3.id, unit_price:100, quantity:2)

    get "/api/v1/items/#{items[0].id}/best_day"

    best_day = JSON.parse(response.body)

    expect(response).to be_success
    expect(best_day).to eq({"best_day" => time1})
  end
end