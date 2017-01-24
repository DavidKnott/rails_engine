require "rails_helper"

describe "Finds Invoices API" do
  before do
    customer = create(:customer)
    @invoice = customer.invoices.create(status: "limbo")
    create_list(:invoice, 2)
  end

  it "returns the correct invoice given an id parameter" do
    get "/api/v1/invoices/find?id=1"
    invoice_json = JSON.parse(response.body)

    expect(invoice_json["id"]).to eql(@invoice.id)
    expect(invoice_json["status"]).to eql("limbo")
  end

  it "returns the first invoice with a given status parameter" do
    get "/api/v1/invoices/find?status=limbo"
    invoice_json = JSON.parse(response.body)

    expect(invoice_json["id"]).to eql(@invoice.id)
    expect(invoice_json["status"]).to eql("limbo")
  end

  xit "returns the first invoice with a given created_at parameter" do
    get "/api/v1/invoices/find?created_at=XXXX"
    invoice_json = JSON.parse(response.body)

    expect(invoice_json["id"]).to eql(@invoice.id)
    expect(invoice_json["status"]).to eql("limbo")
  end

  xit "returns the first invoice with a given updated_at parameter" do
    get "/api/v1/invoices/find?updated_at=XXXX"
    invoice_json = JSON.parse(response.body)

    expect(invoice_json["id"]).to eql(@invoice.id)
    expect(invoice_json["status"]).to eql("limbo")
  end
end
