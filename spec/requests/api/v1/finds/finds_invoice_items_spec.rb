require "rails_helper"

describe "Finds Invoice Items API" do
  before do
    item = create(:item)
    invoice = create(:invoice)
    @invoice_item_1 = item.invoice_items.create!(invoice: invoice,
                                                quantity: 5,
                                                unit_price: 87)
    item.invoice_items.create!(invoice: invoice,
                              quantity: 5,
                              unit_price: 87)
    create_list(:invoice_item, 2)
  end

  it "returns the correct invoice given an id parameter" do
    get "/api/v1/invoice_items/find?id=1"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json["id"]).to eql(@invoice_item_1.id)
    expect(invoice_item_json["quantity"]).to eql(5)
    expect(invoice_item_json["unit_price"]).to eql(87)
  end

  it "returns the first invoice with a given quantity parameter" do
    get "/api/v1/invoice_items/find?quantity=5"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json["id"]).to eql(@invoice_item_1.id)
    expect(invoice_item_json["quantity"]).to eql(5)
    expect(invoice_item_json["unit_price"]).to eql(87)
  end

  it "returns the first invoice with a given unit_price parameter" do
    get "/api/v1/invoice_items/find?unit_price=87"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json["id"]).to eql(@invoice_item_1.id)
    expect(invoice_item_json["quantity"]).to eql(5)
    expect(invoice_item_json["unit_price"]).to eql(87)
  end

  xit "returns the first invoice with a given created_at parameter" do
    get "/api/v1/invoice_items/find?created_at=XXXX"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json["id"]).to eql(@invoice_item_1.id)
    expect(invoice_item_json["quantity"]).to eql(5)
    expect(invoice_item_json["unit_price"]).to eql(87)
  end

  xit "returns the first invoice with a given updated_at parameter" do
    get "/api/v1/invoice_items/find?updated_at=XXXX"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json["id"]).to eql(@invoice_item_1.id)
    expect(invoice_item_json["quantity"]).to eql(5)
    expect(invoice_item_json["unit_price"]).to eql(87)
  end

  it "returns an array with the correct invoice_item given an id parameter" do
    get "/api/v1/invoice_items/find_all?id=1"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json[0]["id"]).to eql(@invoice_item_1.id)
    expect(invoice_item_json[0]["quantity"]).to eql(5)
    expect(invoice_item_json[0]["unit_price"]).to eql(87)
  end

  it "returns all invoice_items with a specified quantity" do
    get "/api/v1/invoice_items/find_all?quantity=5"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json.length).to eql(2)
    2.times do |i|
      expect(invoice_item_json[i]["quantity"]).to eql(5)
      expect(invoice_item_json[i]["unit_price"]).to eql(87)
    end
  end

  it "returns all invoice_items with a specified unit_price" do
    get "/api/v1/invoice_items/find_all?unit_price=87"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json.length).to eql(2)
    2.times do |i|
      expect(invoice_item_json[i]["quantity"]).to eql(5)
      expect(invoice_item_json[i]["unit_price"]).to eql(87)
    end
  end

  xit "returns all invoice_items with a specified created_at parameter" do
    get "/api/v1/invoice_items/find_all?created_at=XXXX"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json.length).to eql(2)
    2.times do |i|
      expect(invoice_item_json[i]["quantity"]).to eql(5)
      expect(invoice_item_json[i]["unit_price"]).to eql(87)
    end
  end

  xit "returns all invoice_items with a specified updated_at parameter" do
    get "/api/v1/invoice_items/find_all?updated_at=XXXX"
    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json.length).to eql(2)
    2.times do |i|
      expect(invoice_item_json[i]["quantity"]).to eql(5)
      expect(invoice_item_json[i]["unit_price"]).to eql(87)
    end
  end
end
