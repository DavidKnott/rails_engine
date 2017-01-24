require "rails_helper"

describe "Finds Items API" do
  before do
    merchant = create(:merchant)
    @time = Time.now.iso8601
    @item = merchant.items.create!(name: "Pants",
                                    description: "Blue jeans",
                                    unit_price: 10,
                                    created_at: @time,
                                    updated_at: @time)
    create_list(:item, 2)
  end

  it "returns the correct item given an id parameter" do
    get "/api/v1/items/find?id=1"
    item_json = JSON.parse(response.body)

    expect(item_json["id"]).to eql(@item.id)
    expect(item_json["name"]).to eql(@item.name)
    expect(item_json["description"]).to eql(@item.description)
    expect(item_json["unit_price"]).to eql(@item.unit_price)
    expect(item_json["merchant_id"]).to eql(@item.merchant.id)
  end

  it "returns the correct item given a name parameter" do
    get "/api/v1/items/find?name=Pants"
    item_json = JSON.parse(response.body)

    expect(item_json["id"]).to eql(@item.id)
    expect(item_json["name"]).to eql(@item.name)
    expect(item_json["description"]).to eql(@item.description)
    expect(item_json["unit_price"]).to eql(@item.unit_price)
    expect(item_json["merchant_id"]).to eql(@item.merchant.id)
  end

  xit "returns the correct item given a created_at parameter" do
    get "/api/v1/items/find?created_at=#{@time}"
    item_json = JSON.parse(response.body)

    expect(item_json["id"]).to eql(@item.id)
    expect(item_json["name"]).to eql(@item.name)
    expect(item_json["description"]).to eql(@item.description)
    expect(item_json["unit_price"]).to eql(@item.unit_price)
    expect(item_json["merchant_id"]).to eql(@item.merchant.id)
  end

  xit "returns the correct item given an updated_at parameter" do
    get "/api/v1/items/find?updated_at=#{@time}"
    item_json = JSON.parse(response.body)

    expect(item_json["id"]).to eql(@item.id)
    expect(item_json["name"]).to eql(@item.name)
    expect(item_json["description"]).to eql(@item.description)
    expect(item_json["unit_price"]).to eql(@item.unit_price)
    expect(item_json["merchant_id"]).to eql(@item.merchant.id)
  end
end
