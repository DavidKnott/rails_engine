require "rails_helper"

describe "Items API" do
  it "returns a list of items" do
    create_list(:item, 3, unit_price: 100)
    get "/api/v1/items"
    items_json = JSON.parse(response.body)
    items = Item.all

    expect(response).to be_success
    expect(items_json.count).to eql(3)

    items.each_with_index do |item, i|
      expect(items_json[i]["name"]).to eql(item.name)
      expect(items_json[i]["description"]).to eql(item.description)
      expect(items_json[i]["unit_price"]).to eql("1.00")
    end
  end

  it "returns one item" do
    item = create(:item, unit_price: 100)
    get "/api/v1/items/#{item.id}"
    item_json = JSON.parse(response.body)
    item = Item.first

    expect(item_json["name"]).to eql(item.name)
    expect(item_json["description"]).to eql(item.description)
    expect(item_json["unit_price"]).to eql("1.00")
  end
end
