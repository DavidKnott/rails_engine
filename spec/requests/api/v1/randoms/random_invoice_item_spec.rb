require "rails_helper"

describe "Random Invoice Item API" do
  before do
    create_list(:invoice_item, 5)
  end

  it "returns a random invoice_item" do
    get "/api/v1/invoice_items/random"
    invoice_item_1_id = JSON.parse(response.body)["id"]

    get "/api/v1/invoice_items/random"
    invoice_item_2_id = JSON.parse(response.body)["id"]

    get "/api/v1/invoice_items/random"
    invoice_item_3_id = JSON.parse(response.body)["id"]

    get "/api/v1/invoice_items/random"
    invoice_item_4_id = JSON.parse(response.body)["id"]

    ids = [invoice_item_1_id, invoice_item_2_id, invoice_item_3_id, invoice_item_4_id]

    expect(ids.uniq.length).to be > 1
  end
end
