require "rails_helper"

describe "Invoice Items API" do
  it "returns a list of invoice items" do
    create_list(:invoice_item, 3)
    get "/api/v1/invoice_items"
    invoice_items_json = JSON.parse(response.body)
    invoice_items = InvoiceItem.all

    expect(response).to be_success
    expect(invoice_items_json.count).to eql(3)
    invoice_items_json.each do |invoice_item_json|
      expect(invoice_item_json).to be_a(Hash)
      expect(invoice_item_json).to have_key("id")
      expect(invoice_item_json).to have_key("item_id")
      expect(invoice_item_json).to have_key("invoice_id")
      expect(invoice_item_json).to have_key("quantity")
      expect(invoice_item_json).to have_key("unit_price")
      expect(invoice_item_json).to have_key("created_at")
      expect(invoice_item_json).to have_key("updated_at")
    end
    invoice_items.each_with_index do |invoice_item, i|
      expect(invoice_items_json[i]["id"]).to eql(invoice_item.id)
      expect(invoice_items_json[i]["item_id"]).to eql(invoice_item.item_id)
      expect(invoice_items_json[i]["invoice_id"]).to eql(invoice_item.invoice_id)
      expect(invoice_items_json[i]["quantity"]).to eql(invoice_item.quantity)
      expect(invoice_items_json[i]["unit_price"]).to eql(invoice_item.unit_price)
    end
  end

  it "returns one invoice item" do
    invoice_item = create(:invoice_item)
    get "/api/v1/invoice_items/#{invoice_item.id}"
    invoice_item_json = JSON.parse(response.body)
    invoice_item = InvoiceItem.first

    expect(invoice_item_json).to be_a(Hash)
    expect(invoice_item_json["item_id"]).to eql(invoice_item.item.id)
    expect(invoice_item_json["invoice_id"]).to eql(invoice_item.invoice.id)
    expect(invoice_item_json["quantity"]).to eql(invoice_item.quantity)
    expect(invoice_item_json["unit_price"]).to eql(invoice_item.unit_price)
  end
end
