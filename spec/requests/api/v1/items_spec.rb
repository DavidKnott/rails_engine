require "rails_helper"

describe "Items API" do
  it "returns a list of items" do
    create_list(:item, 3)
    get "/api/v1/items"
    items_json = JSON.parse(response.body)
    items = Item.all

    expect(response).to be_success
    expect(items_json.count).to eql(3)
    items_json.each do |item_json|
      expect(item_json).to be_a(Hash)
      expect(item_json).to have_key("id")
      expect(item_json).to have_key("name")
      expect(item_json).to have_key("description")
      expect(item_json).to have_key("unit_price")
      expect(item_json).to have_key("created_at")
      expect(item_json).to have_key("updated_at")
    end
    items.each_with_index do |item, i|
      expect(items_json[i]["name"]).to eql(item.name)
      expect(items_json[i]["description"]).to eql(item.description)
      expect(items_json[i]["unit_price"]).to eql(item.unit_price)
    end
  end
end
