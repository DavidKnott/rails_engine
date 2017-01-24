require "rails_helper"

describe "Finds Invoice Items API" do
  before do
    item = create(:item)
    invoice = create(:invoice)
    @invoice_item = item.invoice_items.create!(invoice: invoice,
                                                quantity: 5,
                                                unit_price: 100)
    create_list(:invoice_item, 2)
  end

  it "returns the correct invoice given an id parameter" do
    get "/api/v1/invoice_items/find?id=1"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json["id"]).to eql(@invoice_item.id)
    expect(invoice_item_json["quantity"]).to eql(5)
    expect(invoice_item_json["unit_price"]).to eql(100)
  end

  it "returns the first invoice with a given quantity parameter" do
    get "/api/v1/invoice_items/find?quantity=5"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json["id"]).to eql(@invoice_item.id)
    expect(invoice_item_json["quantity"]).to eql(5)
    expect(invoice_item_json["unit_price"]).to eql(100)
  end

  it "returns the first invoice with a given unit_price parameter" do
    get "/api/v1/invoice_items/find?unit_price=100"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json["id"]).to eql(@invoice_item.id)
    expect(invoice_item_json["quantity"]).to eql(5)
    expect(invoice_item_json["unit_price"]).to eql(100)
  end

  xit "returns the first invoice with a given created_at parameter" do
    get "/api/v1/invoice_items/find?created_at=XXXX"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json["id"]).to eql(@invoice_item.id)
    expect(invoice_item_json["quantity"]).to eql(5)
    expect(invoice_item_json["unit_price"]).to eql(100)
  end

  xit "returns the first invoice with a given updated_at parameter" do
    get "/api/v1/invoice_items/find?updated_at=XXXX"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json["id"]).to eql(@invoice_item.id)
    expect(invoice_item_json["quantity"]).to eql(5)
    expect(invoice_item_json["unit_price"]).to eql(100)
  end
end
