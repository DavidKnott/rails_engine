require "rails_helper"

describe "Invoice Item Relations API" do
  before do
    @merchant = create(:merchant)
    @item_1 = @merchant.items.create!(name:"Cool Tshirt",
                                    description: "The coolest tshirt ever",
                                    unit_price: 1000)
    item_2 = create(:item)
    @customer = create(:customer)
    @invoice_1 = @customer.invoices.create!(merchant: @merchant,
                                            status: "limbo")
    invoice_2 = create(:invoice)
    @invoice_item_1 = @item_1.invoice_items.create!(invoice: @invoice_1,
                                                    quantity: 8,
                                                    unit_price: 200)
    item_2.invoice_items.create!(invoice: invoice_2,
                                  quantity: 4,
                                  unit_price: 400)
  end

  it "returns the associated invoice" do
    get "/api/v1/invoice_items/#{@invoice_item_1.id}/invoice"
    invoice_json = JSON.parse(response.body)

    expect(invoice_json["id"]).to eql(@invoice_1.id)
    expect(invoice_json["customer_id"]).to eql(@customer.id)
    expect(invoice_json["merchant_id"]).to eql(@merchant.id)
    expect(invoice_json["status"]).to eql("limbo")
  end

  it "returns the associated item" do
    get "/api/v1/invoice_items/#{@invoice_item_1.id}/item"
    item_json = JSON.parse(response.body)

    expect(item_json["id"]).to eql(@item_1.id)
    expect(item_json["name"]).to eql("Cool Tshirt")
    expect(item_json["description"]).to eql("The coolest tshirt ever")
    expect(item_json["unit_price"]).to eql("10.00")
  end
end
