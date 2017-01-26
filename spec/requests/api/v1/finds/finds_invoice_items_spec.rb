require "rails_helper"

describe "Finds Invoice Items API" do
  before do
    @time = "2012-03-27T14:54:05.000Z"
    item = create(:item)
    invoice = create(:invoice)
    @invoice_item_1 = item.invoice_items.create!(invoice: invoice,
                                                quantity: 5,
                                                unit_price: 87,
                                                created_at: "2012-03-27 14:54:05 UTC",
                                                updated_at: "2012-03-27 14:54:05 UTC")
    item.invoice_items.create!(invoice: invoice,
                              quantity: 5,
                              unit_price: 87,
                              created_at: "2012-03-27 14:54:05 UTC",
                              updated_at: "2012-03-27 14:54:05 UTC")
    create_list(:invoice_item, 2)
  end

  it "returns the correct invoice item given an id parameter" do
    get "/api/v1/invoice_items/find?id=1"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json["quantity"]).to eql(5)
    expect(invoice_item_json["unit_price"]).to eql("0.87")
  end

  it "returns the first invoice item with a given quantity parameter" do
    get "/api/v1/invoice_items/find?quantity=5"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json["quantity"]).to eql(5)
    expect(invoice_item_json["unit_price"]).to eql("0.87")
  end

  it "returns the first invoice item with a given unit_price parameter" do
    get "/api/v1/invoice_items/find?unit_price=87"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json["quantity"]).to eql(5)
    expect(invoice_item_json["unit_price"]).to eql("0.87")
  end

  it "returns the first invoice item with a given created_at parameter" do
    get "/api/v1/invoice_items/find?created_at=#{@time}"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json["id"]).to eql(@invoice_item_1.id)
    expect(invoice_item_json["quantity"]).to eql(5)
    expect(invoice_item_json["unit_price"]).to eql("0.87")
  end

  it "returns the first invoice item with a given updated_at parameter" do
    get "/api/v1/invoice_items/find?updated_at=#{@time}"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json["id"]).to eql(@invoice_item_1.id)
    expect(invoice_item_json["quantity"]).to eql(5)
    expect(invoice_item_json["unit_price"]).to eql("0.87")
  end

  it "returns an array with the correct invoice itemss given an id parameter" do
    get "/api/v1/invoice_items/find_all?id=1"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json[0]["quantity"]).to eql(5)
    expect(invoice_item_json[0]["unit_price"]).to eql("0.87")
  end

  it "returns all invoice_items with a specified quantity" do
    get "/api/v1/invoice_items/find_all?quantity=5"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json.length).to eql(2)
    2.times do |i|
      expect(invoice_item_json[i]["quantity"]).to eql(5)
      expect(invoice_item_json[i]["unit_price"]).to eql("0.87")
    end
  end

  it "returns all invoice items with a specified unit_price" do
    get "/api/v1/invoice_items/find_all?unit_price=87"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json.length).to eql(2)
    2.times do |i|
      expect(invoice_item_json[i]["quantity"]).to eql(5)
      expect(invoice_item_json[i]["unit_price"]).to eql("0.87")
    end
  end

  it "returns all invoice items with a specified created_at parameter" do
    get "/api/v1/invoice_items/find_all?created_at=#{@time}"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json.length).to eql(2)
    2.times do |i|
      expect(invoice_item_json[i]["quantity"]).to eql(5)
      expect(invoice_item_json[i]["unit_price"]).to eql("0.87")
    end
  end

  it "returns all invoice items with a specified updated_at parameter" do
    get "/api/v1/invoice_items/find_all?updated_at=#{@time}"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json.length).to eql(2)
    2.times do |i|
      expect(invoice_item_json[i]["quantity"]).to eql(5)
      expect(invoice_item_json[i]["unit_price"]).to eql("0.87")
    end
  end
end
