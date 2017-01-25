require "rails_helper"

describe "Invoice Relations API" do
  before do
    #create a merchant
    @merchant_1 = Merchant.create!(name: "Best Store Ever")

    #create some items for that merchant and one random item
    @item_1 = @merchant_1.items.create!(name: "Cool Tshirt",
                                      description: "The coolest tshirt ever",
                                      unit_price: 1000)
    @item_2 = @merchant_1.items.create!(name: "Pretty Cool Tshirt",
                                      description: "The second coolest tshirt ever",
                                      unit_price: 900)
    create(:item)

    #create a couple customers
    @customer_1 = Customer.create!(first_name: "Jane",
                                  last_name: "Doe")
    create(:customer)

    #create a couple invoices for the first customer
    #note that the invoice_items created above are assigned to the first invoice
    @invoice_1 = @customer_1.invoices.create!(status: "limbo")
    invoice_2 = @customer_1.invoices.create!(status: "limbo")

    #create transactions for those invoices
    @invoice_1.transactions.create!(credit_card_number: 1111222233334444,
                                    result: "done")
    @invoice_1.transactions.create!(credit_card_number: 1111222233334444,
                                    result: "done")
    invoice_2.transactions.create!(credit_card_number: 4444333322221111,
                                  result: "success")

    #create an invoice_item for each item, assign them to the first invoice
    invoice_item_1 = @item_1.invoice_items.create!(invoice: @invoice_1,
                                                    quantity: 7,
                                                    unit_price: 1000)
    invoice_item_2 = @item_2.invoice_items.create!(invoice: @invoice_1,
                                                    quantity: 4,
                                                    unit_price: 900)
    create(:invoice_item)
  end

  it "returns a collection of associated transactions" do
    get "/api/v1/invoices/#{@invoice_1.id}/transactions"
    transactions_json = JSON.parse(response.body)

    expect(transactions_json.count).to eql(2)
    transactions_json.each do |transaction_json|
      expect(transaction_json["credit_card_number"]).to eql("1111222233334444")
      expect(transaction_json["result"]).to eql("done")
    end
  end

  it "returns a collection of associated invoice items" do
    get "/api/v1/invoices/#{@invoice_1.id}/invoice_items"
    invoice_items_json = JSON.parse(response.body)

    expect(invoice_items_json.count).to eql(2)
    expect(invoice_items_json[0]["quantity"]).to eql(7)
    expect(invoice_items_json[0]["unit_price"]).to eql(1000)
    expect(invoice_items_json[1]["quantity"]).to eql(4)
    expect(invoice_items_json[1]["unit_price"]).to eql(900)
  end

  it "returns a collection of associated items" do
    get "/api/v1/invoices/#{@invoice_1.id}/items"
    the_invoices_items_json = JSON.parse(response.body)

    expect(the_invoices_items_json.count).to eql(2)
    expect(the_invoices_items_json[0]["name"]).to eql("Cool Tshirt")
    expect(the_invoices_items_json[0]["description"]).to eql("The coolest tshirt ever")
    expect(the_invoices_items_json[0]["unit_price"]).to eql(1000)
    expect(the_invoices_items_json[1]["name"]).to eql("Pretty Cool Tshirt")
    expect(the_invoices_items_json[1]["description"]).to eql("The second coolest tshirt ever")
    expect(the_invoices_items_json[1]["unit_price"]).to eql(900)
  end

  it "returns the associated customer" do
    get "/api/v1/invoices/#{@invoice_1.id}/customer"
    customer_json = JSON.parse(response.body)

    expect(customer_json["first_name"]).to eql("Jane")
    expect(customer_json["last_name"]).to eql("Doe")
  end

  it "returns the associated merchant" do
    get "/api/v1/invoices/#{@invoice_1.id}/merchant"
    merchant_json = JSON.parse(response.body)

    expect(merchant_json["name"]).to eql("Best Store Ever")
  end
end
