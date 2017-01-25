require "rails_helper"

describe "Random Item API" do
  before do
    merchant = create(:merchant)
    create_list(:item, 5)
  end

  it "returns a random item" do
    get "/api/v1/items/random"
    item_1_id = JSON.parse(response.body)["id"]

    get "/api/v1/items/random"
    item_2_id = JSON.parse(response.body)["id"]

    get "/api/v1/items/random"
    item_3_id = JSON.parse(response.body)["id"]

    get "/api/v1/items/random"
    item_4_id = JSON.parse(response.body)["id"]

    ids = [item_1_id, item_2_id, item_3_id, item_4_id]

    expect(ids.uniq.length).to be > 1
  end
end
