require "rails_helper"

describe "Top Merchants by Revenue API" do
  before do
    #create three merchants
    @pretty_good_merchant, @okay_merchant, @best_merchant = create_list(:merchant, 3)

    #create an item for each merchant
    best_item = @best_merchant.items.create!(name: "Best",
                                              description: "The best",
                                              unit_price: 1000)
    pretty_good_item = @pretty_good_merchant.items.create!(name: "Pretty Good",
                                                            description: "Pretty much good",
                                                            unit_price: 800)
    okay_item = @okay_merchant.items.create!(name: "Okay",
                                              description: "Just okay",
                                              unit_price: 400)

    #create a customer
    customer = create(:customer)

    #create four invoices, make sure one of them is failed
    invoice_1 = customer.invoices.create!(merchant: @best_merchant,
                                          status: "shipped")
    invoice_2 = customer.invoices.create!(merchant: @pretty_good_merchant,
                                          status: "shipped")
    invoice_3 = customer.invoices.create!(merchant: @okay_merchant,
                                          status: "shipped")
    invoice_4 = customer.invoices.create!(merchant: @pretty_good_merchant,
                                          status: "shipped")

    #create transactions for those invoices, make sure one is failed
    invoice_1.transactions.create!(credit_card_number: "1111222233334444",
                                    result: "success")
    invoice_2.transactions.create!(credit_card_number: "1111222233334444",
                                    result: "success")
    invoice_3.transactions.create!(credit_card_number: "1111222233334444",
                                    result: "success")
    invoice_4.transactions.create!(credit_card_number: "1111222233334444",
                                    result: "failed")

    #create four invoice_items
    invoice_item_1 = best_item.invoice_items.create!(invoice: invoice_1,
                                                      quantity: 10,
                                                      unit_price: 1)
    invoice_item_2 = best_item.invoice_items.create!(invoice: invoice_2,
                                                      quantity: 10,
                                                      unit_price: 1)
    invoice_item_3 = best_item.invoice_items.create!(invoice: invoice_3,
                                                      quantity: 10,
                                                      unit_price: 1)
    invoice_item_4 = best_item.invoice_items.create!(invoice: invoice_4,
                                                      quantity: 10,
                                                      unit_price: 1)
  end

  it "returns the top 2 merchants ranked by total revenue generated" do
    get "/api/v1/merchants/most_revenue?quantity=2"
    merchants_json = JSON.parse(response.body)

    expect(merchants_json.length).to eql(2)
    expect(merchants_json[0]["id"]).to eql(1)
    expect(merchants_json[1]["id"]).to eql(2)
  end

  it "returns the top merchant by total revenue if it's not given a quantity" do
    get "/api/v1/merchants/most_revenue"
    merchants_json = JSON.parse(response.body)

    expect(merchants_json.length).to eql(1)
    expect(merchants_json[0]["id"]).to eql(1)
  end
end
