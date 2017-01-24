require "rails_helper"

describe "Invoices API" do
  it "returns a list of invoices" do
    create_list(:invoice, 3)
    get "/api/v1/invoices"
    invoices_json = JSON.parse(response.body)
    invoices = Invoice.all

    expect(response).to be_success
    expect(invoices_json.count).to eql(3)
    invoices_json.each do |invoice_json|
      expect(invoice_json).to be_a(Hash)
      expect(invoice_json).to have_key("id")
      expect(invoice_json).to have_key("customer_id")
      expect(invoice_json).to have_key("status")
      expect(invoice_json).to have_key("created_at")
      expect(invoice_json).to have_key("updated_at")
    end
    invoices.each_with_index do |invoice, i|
      expect(invoices_json[i]["id"]).to eql(invoice.id)
      expect(invoices_json[i]["customer_id"]).to eql(invoice.customer_id)
      expect(invoices_json[i]["status"]).to eql(invoice.status)
    end
  end

  it "returns one invoice" do
    invoice = create(:invoice)
    get "/api/v1/invoices/#{invoice.id}"
    invoice_json = JSON.parse(response.body)
    invoice = Invoice.first

    expect(invoice_json).to be_a(Hash)
    expect(invoice_json["customer_id"]).to eql(invoice.customer.id)
    expect(invoice_json["status"]).to eql(invoice.status)
  end
end
