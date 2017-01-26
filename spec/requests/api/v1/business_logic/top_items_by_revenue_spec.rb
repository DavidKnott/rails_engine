require "rails_helper"

describe "Top Items by Revenue API" do
  before do
    merchant = create(:merchant)

    @pretty_cool_item = merchant.items.create!(name: "Pretty Cool Tshirt",
                                      description: "This tshirt is pretty cool.",
                                      unit_price: 800)
    @okay_item = merchant.items.create!(name: "Okay Tshirt",
                                      description: "This tshirt is just okay.",
                                      unit_price: 500)
    @coolest_item = merchant.items.create!(name: "Coolest Tshirt",
                                      description: "The coolest tshirt ever.",
                                      unit_price: 1000)

    customer = create(:customer)
    invoice_success = merchant.invoices.create!(customer: customer,
                                                status: "shipped")
    invoice_failed = merchant.invoices.create!(customer: customer,
                                                status: "shipped")

    invoice_item_1 = @coolest_item.invoice_items.create!(invoice: invoice_success,
                                                    quantity: 10,
                                                    unit_price: 1)
    invoice_item_2 = @pretty_cool_item.invoice_items.create!(invoice: invoice_success,
                                                    quantity: 6,
                                                    unit_price: 1)
    invoice_item_3 = @okay_item.invoice_items.create!(invoice: invoice_success,
                                                    quantity: 1,
                                                    unit_price: 1)
    invoice_item_4 = @pretty_cool_item.invoice_items.create!(invoice: invoice_failed,
                                                    quantity: 7,
                                                    unit_price: 1)

    invoice_success.transactions.create!(credit_card_number: "1111222233334444",
                                          result: "success")
    invoice_failed.transactions.create!(credit_card_number: "1111222233334444",
                                        result: "failed")

  end

  xit "returns the top 2 items ranked by total revenue generated" do
    get "/api/v1/items/most_revenue?quantity=2"
    items_json = JSON.parse(response.body)
    byebug

    expect(items_json.length).to eql(2)
    expect(items_json[0]["id"]).to eql(@coolest_item.id)
    expect(items_json[0]["name"]).to eql("Coolest Tshirt")
    expect(items_json[1]["id"]).to eql(@pretty_cool_item.id)
    expect(items_json[1]["name"]).to eql("Pretty Cool Tshirt")
  end

  xit "returns the top item by total revenue if it's not given a quantity" do
    get "/api/v1/items/most_revenue"
    items_json = JSON.parse(response.body)

    expect(items_json.length).to eql(1)
    expect(items_json[0]["id"]).to eql(@coolest_item.id)
    expect(items_json[0]["name"]).to eql("Coolest Tshirt")
  end
end
