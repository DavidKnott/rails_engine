require 'rails_helper'

describe "Merchant Business Intelligence" do

  before(:each) do
    @time = "2012-03-27T14:54:05.000Z"
    @merchant = create_list(:merchant_with_invoices, 1, invoices_count: 1).first
    @invoice = @merchant.invoices.create(status: "limbo", created_at: @time, customer_id: 1)
    transactions = create_list(:transaction, 2, result: "success", invoice_id: @invoice.id)
    item = create_list(:item, 3).first
    create_list(:invoice_item, 1, item_id: item.id, invoice_id: @invoice.id, unit_price:100, quantity:2)
  end

  it "returns the total revenue for a single merchant" do
    get "/api/v1/merchants/#{@merchant.id}/revenue"
    
    revenue = JSON.parse(response.body)

    expect(revenue).to eq({'revenue' => '4.00'})
  end

  it "returns the total revenue for a single merchant on a given day" do
    get "/api/v1/merchants/#{@merchant.id}/revenue?date=#{@time}"
    revenue = JSON.parse(response.body)

    expect(revenue).to eq({'revenue' => '4.00'})
  end

  it "returns list of the merchants with the most items sold" do
    merchants = create_list(:merchant, 10)
    merchants.each do |merchant|
      merchant.items << create(:item)
      merchant.items.each do |item|
        invoice = create(:invoice, merchant_id: merchant.id)
        transaction = create(:transaction, invoice_id: invoice.id)
        item.invoice_items.create(item_id: item.id, invoice_id: invoice.id, unit_price:100, quantity:2)
      end
    end

    get '/api/v1/merchants/most_items?quantity=3'

    merchants_json = JSON.parse(response.body)
    merchant_json = Merchant.find(merchants_json.last["id"])

    expect(merchants_json.count).to eq 3
    expect(merchant_json.items.count).to eq 1
  end

  it "returns all customers with pending invoices" do
    merchant = create(:merchant_with_invoices, invoices_count: 3)
    customers = create_list(:customer, 4)
    invoice1 = merchant.invoices.create(status: "limbo", customer_id: customers[0].id)
    invoice2 = merchant.invoices.create(status: "limbo", customer_id: customers[1].id)
    invoice3 = merchant.invoices.create(status: "limbo", customer_id: customers[2].id)
    create(:transaction, result: "failure", invoice_id: invoice1.id)
    create(:transaction, result: "failure", invoice_id: invoice2.id)
    create(:transaction, result: "failure", invoice_id: invoice2.id)
    create(:transaction, result: "failure", invoice_id: invoice3.id)
    
    item = create_list(:item, 3).first
    create_list(:invoice_item, 1, item_id: item.id, invoice_id: invoice1.id, unit_price:100, quantity:2)

    get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

    customers_json = JSON.parse(response.body)
    customer_json = customers_json.first

    expect(response).to be_success
    expect(customers_json.count).to eq 3
    expect(customer_json['id']).to eq 6
  end
end