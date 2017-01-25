require "rails_helper"

describe "Random Invoice API" do
  before do
    create_list(:invoice, 5)
  end

  it "returns a random invoice" do
    get "/api/v1/invoices/random"
    invoice_1_id = JSON.parse(response.body)["id"]

    get "/api/v1/invoices/random"
    invoice_2_id = JSON.parse(response.body)["id"]

    get "/api/v1/invoices/random"
    invoice_3_id = JSON.parse(response.body)["id"]

    get "/api/v1/invoices/random"
    invoice_4_id = JSON.parse(response.body)["id"]

    ids = [invoice_1_id, invoice_2_id, invoice_3_id, invoice_4_id]

    expect(ids.uniq.length).to be > 1
  end
end
