require "rails_helper"

describe "All Merchants Revenue on Date API" do
  before do
    @datetime = "2012-03-16 11:55:05"
    @total_revenue = "25.00"

    #create some merchants
    merchant_1, merchant_2 = create_list(:merchant, 2)
    #create some items for each merchant
    item_1 = merchant_1.items.create!(name: "Item 1",
                                      description: "This is item 1.",
                                      unit_price: 1000)
    item_2 = merchant_2.items.create!(name: "Item 2",
                                      description: "This is item 2.",
                                      unit_price: 500)

    #create a customer
    customer = create(:customer)

    #create some invoices
    invoice_1 = customer.invoices.create!(merchant: merchant_1,
                                          status: "shipped",
                                          created_at: @datetime)
    invoice_2 = customer.invoices.create!(merchant: merchant_1,
                                          status: "shipped",
                                          created_at: @datetime)
    invoice_3 = customer.invoices.create!(merchant: merchant_2,
                                          status: "shipped",
                                          created_at: @datetime)
    invoice_4_failed = customer.invoices.create!(merchant: merchant_2,
                                          status: "shipped",
                                          created_at: @datetime)

    #create some transactions, make some failed
    transaction_1 = invoice_1.transactions.create!(credit_card_number: "1111222233334444",
                                                    result: "success")
    transaction_2 = invoice_2.transactions.create!(credit_card_number: "1111222233334444",
                                                    result: "success")
    transaction_3 = invoice_3.transactions.create!(credit_card_number: "1111222233334444",
                                                    result: "success")
    transaction_4 = invoice_4_failed.transactions.create!(credit_card_number: "1111222233334444",
                                                    result: "failed")

    #create some invoice_items
    invoice_item_1 = invoice_1.invoice_items.create!(item: item_1,
                                                      quantity: 1,
                                                      unit_price: 1000)
    invoice_item_2 = invoice_2.invoice_items.create!(item: item_1,
                                                      quantity: 1,
                                                      unit_price: 1000)
    invoice_item_3 = invoice_3.invoice_items.create!(item: item_2,
                                                      quantity: 1,
                                                      unit_price: 500)
    invoice_item_4_failed = invoice_4_failed.invoice_items.create!(item: item_2,
                                                                    quantity: 1,
                                                                    unit_price: 500)
  end

  it "returns the total revenue for date x across all merchants" do
    get "/api/v1/merchants/revenue?date=#{@datetime}"
    revenue_json = JSON.parse(response.body)

    expect(revenue_json["total_revenue"]).to eql(@total_revenue)
  end
end
