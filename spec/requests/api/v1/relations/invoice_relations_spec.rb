require "rails_helper"

describe "Invoice Relations API" do
  before do
    # @merchant_1 = create(:merchants_with_invoices)
    # @invoice1 = @merchant_1.invoices.first
    # @customer_1 = create(:customer_with_invoices)
    # @invoice_1 = @customer_1.invoices.create!(status: "limbo")

    #create an invoice_item for each item, assign them to the first invoice
    
    # invoice_item_2 = @item_2.invoice_items.create!(invoice: @invoice_1,
    #                                                 quantity: 4,
    #                                                 unit_price: 900)
    # create(:invoice_item)
  end

  it "returns a collection of associated transactions" do
    invoice = create(:invoice)
    invoice.transactions.create!(credit_card_number: "1111222233334444",
                                    result: "done")
    invoice.transactions.create!(credit_card_number: "1111222233334444",
                                    result: "done")
    get "/api/v1/invoices/#{invoice.id}/transactions"
    transactions_json = JSON.parse(response.body)

    expect(transactions_json.count).to eql(2)
    transactions_json.each do |transaction_json|
      expect(transaction_json["credit_card_number"]).to eql("1111222233334444")
      expect(transaction_json["result"]).to eql("done")
    end
  end

  it "returns a collection of associated invoice items" do
    invoice = create(:invoice_with_invoice_items, invoice_items_count: 2)
    get "/api/v1/invoices/#{invoice.id}/invoice_items"
    invoice_items_json = JSON.parse(response.body)

    expect(invoice_items_json.count).to eql(2)
    expect(invoice_items_json[0]["quantity"]).to eql(2)
    expect(invoice_items_json[0]["unit_price"]).to eql("1.00")
  end

  it "returns a collection of associated items" do
    merchant = create(:merchant)
    invoice = create(:invoice)
    item = Item.create!({name:"Cool Tshirt", 
                          description: "The coolest tshirt ever",
                          unit_price: 1000,
                          merchant_id: merchant.id
                          })
    item.invoice_items.create!(invoice_id: invoice.id,
                                quantity: 7,
                                unit_price: 1000)
    get "/api/v1/invoices/#{invoice.id}/items"
    the_invoices_items_json = JSON.parse(response.body)

    expect(the_invoices_items_json.count).to eql(1)
    expect(the_invoices_items_json[0]["name"]).to eql("Cool Tshirt")
    expect(the_invoices_items_json[0]["description"]).to eql("The coolest tshirt ever")
    expect(the_invoices_items_json[0]["unit_price"]).to eql("10.00")
<<<<<<< HEAD
=======
    expect(the_invoices_items_json[1]["name"]).to eql("Pretty Cool Tshirt")
    expect(the_invoices_items_json[1]["description"]).to eql("The second coolest tshirt ever")
    expect(the_invoices_items_json[1]["unit_price"]).to eql("9.00")
>>>>>>> fbe6f30f510cb99fe4ef84e1b8567fd26e53c2ee
  end

  it "returns the associated customer" do
    customer = create(:customer_with_invoices, first_name:"Jane", last_name:"Doe")
    invoice = customer.invoices.first
    get "/api/v1/invoices/#{invoice.id}/customer"
    customer_json = JSON.parse(response.body)

    expect(customer_json["first_name"]).to eql("Jane")
    expect(customer_json["last_name"]).to eql("Doe")
  end

  it "returns the associated merchant" do
    merchant = create(:merchants_with_invoices, name: "Best Store Ever")
    invoice = merchant.invoices.first
    get "/api/v1/invoices/#{invoice.id}/merchant"
    merchant_json = JSON.parse(response.body)

    expect(merchant_json["name"]).to eql("Best Store Ever")
  end
end
