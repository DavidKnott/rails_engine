require "rails_helper"

describe "Finds Items API" do
  before do
    merchant = create(:merchant)
    @time = Time.now.iso8601
    @item_1 = merchant.items.create!(name: "Pants",
                                    description: "Blue jeans",
                                    unit_price: 100,
                                    created_at: @time,
                                    updated_at: @time)
    merchant.items.create!(name: "Pants",
                          description: "Blue jeans",
                          unit_price: 100,
                          created_at: @time,
                          updated_at: @time)
    create_list(:item, 2)
  end

  it "returns the correct item given an id parameter" do
    get "/api/v1/items/find?id=1"
    item_json = JSON.parse(response.body)

    expect(item_json["id"]).to eql(@item_1.id)
    expect(item_json["name"]).to eql("Pants")
    expect(item_json["description"]).to eql("Blue jeans")
    expect(item_json["unit_price"]).to eql("1.00")
    expect(item_json["merchant_id"]).to eql(@item_1.merchant.id)
  end

  it "returns the correct item given a name parameter" do
    get "/api/v1/items/find?name=pAnTs"
    item_json = JSON.parse(response.body)

    expect(item_json["id"]).to eql(@item_1.id)
    expect(item_json["name"]).to eql("Pants")
    expect(item_json["description"]).to eql("Blue jeans")
    expect(item_json["unit_price"]).to eql("1.00")
    expect(item_json["merchant_id"]).to eql(@item_1.merchant.id)
  end

  it "returns the correct item given a description parameter" do
    get "/api/v1/items/find?description=bLue jEaNs"
    item_json = JSON.parse(response.body)

    expect(item_json["id"]).to eql(@item_1.id)
    expect(item_json["name"]).to eql("Pants")
    expect(item_json["description"]).to eql("Blue jeans")
    expect(item_json["unit_price"]).to eql("1.00")
    expect(item_json["merchant_id"]).to eql(@item_1.merchant.id)
  end

  it "returns the correct item given a unit_price parameter" do
    get "/api/v1/items/find?unit_price=1.00"
    item_json = JSON.parse(response.body)

    expect(item_json["id"]).to eql(@item_1.id)
    expect(item_json["name"]).to eql("Pants")
    expect(item_json["description"]).to eql("Blue jeans")
    expect(item_json["unit_price"]).to eql("1.00")
    expect(item_json["merchant_id"]).to eql(@item_1.merchant.id)
  end

  it "returns the correct item given a merchant_id parameter" do
    get "/api/v1/items/find?merchant_id=#{@item_1.merchant.id}"
    item_json = JSON.parse(response.body)

    expect(item_json["id"]).to eql(2)
    expect(item_json["name"]).to eql("Pants")
    expect(item_json["description"]).to eql("Blue jeans")
    expect(item_json["unit_price"]).to eql("1.00")
    expect(item_json["merchant_id"]).to eql(@item_1.merchant.id)
  end

  xit "returns the correct item given a created_at parameter" do
    get "/api/v1/items/find?created_at=#{@time}"
    item_json = JSON.parse(response.body)

    expect(item_json["id"]).to eql(@item_1.id)
    expect(item_json["name"]).to eql("Pants")
    expect(item_json["description"]).to eql("Blue jeans")
    expect(item_json["unit_price"]).to eql("1.00")
    expect(item_json["merchant_id"]).to eql(@item_1.merchant.id)
  end

  xit "returns the correct item given an updated_at parameter" do
    get "/api/v1/items/find?updated_at=#{@time}"
    item_json = JSON.parse(response.body)

    expect(item_json["id"]).to eql(@item_1.id)
    expect(item_json["name"]).to eql("Pants")
    expect(item_json["description"]).to eql("Blue jeans")
    expect(item_json["unit_price"]).to eql("1.00")
    expect(item_json["merchant_id"]).to eql(@item_1.merchant.id)
  end

  it "returns an array with the correct item given an id parameter" do
    get "/api/v1/items/find_all?id=1"
    item_json = JSON.parse(response.body)

    expect(item_json[0]["id"]).to eql(@item_1.id)
    expect(item_json[0]["name"]).to eql("Pants")
    expect(item_json[0]["description"]).to eql("Blue jeans")
    expect(item_json[0]["unit_price"]).to eql("1.00")
    expect(item_json[0]["merchant_id"]).to eql(@item_1.merchant.id)
  end

  it "returns all items with a specified name" do
    get "/api/v1/items/find_all?name=pAnTs"
    item_json = JSON.parse(response.body)

    expect(item_json.length).to eql(2)
    2.times do |i|
      expect(item_json[i]["name"]).to eql("Pants")
      expect(item_json[i]["description"]).to eql("Blue jeans")
      expect(item_json[i]["unit_price"]).to eql("1.00")
      expect(item_json[i]["merchant_id"]).to eql(@item_1.merchant.id)
    end
  end

  xit "returns all items with a specified created_at parameter" do
    get "/api/v1/items/find_all?created_at=XXXX"
    item_json = JSON.parse(response.body)

    expect(item_json.length).to eql(2)
    2.times do |i|
      expect(item_json[i]["name"]).to eql("Pants")
      expect(item_json[i]["description"]).to eql("Blue jeans")
      expect(item_json[i]["unit_price"]).to eql(100)
      expect(item_json[i]["merchant_id"]).to eql(@item_1.merchant.id)
    end
  end

  xit "returns all items with a specified updated_at parameter" do
    get "/api/v1/items/find_all?updated_at=XXXX"
    item_json = JSON.parse(response.body)

    expect(item_json.length).to eql(2)
    2.times do |i|
      expect(item_json[i]["name"]).to eql("Pants")
      expect(item_json[i]["description"]).to eql("Blue jeans")
      expect(item_json[i]["unit_price"]).to eql(100)
      expect(item_json[i]["merchant_id"]).to eql(@item_1.merchant.id)
    end
  end
end
