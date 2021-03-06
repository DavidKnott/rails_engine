require "rails_helper"

describe "Finds Invoices API" do
  before do
    @time = "2012-03-27T14:54:05.000Z"
    customer = create(:customer)
    merchant = create(:merchant_with_items)
    @invoice_1 = create_list(:invoice, 2, status: "limbo", 
                        created_at: "2012-03-27 14:54:05 UTC",
                        updated_at: "2012-03-27 14:54:05 UTC").first
    invoice_2 = create(:invoice, status: "limbo") 
    item = merchant.items.first
    create(:invoice_item, item_id: item.id, invoice_id: @invoice_1.id)
    create(:invoice_item, item_id: item.id, invoice_id: invoice_2.id)
    
    create_list(:invoice, 2)
  end

  it "returns the correct invoice given an id parameter" do
    get "/api/v1/invoices/find?id=1"
    invoice_json = JSON.parse(response.body)

    expect(invoice_json["id"]).to eql(@invoice_1.id)
    expect(invoice_json["status"]).to eql("limbo")
  end

  it "returns the first invoice with a given status parameter" do
    get "/api/v1/invoices/find?status=lImBo"
    invoice_json = JSON.parse(response.body)

    expect(invoice_json["id"]).to eql(@invoice_1.id)
    expect(invoice_json["status"]).to eql("limbo")
  end

  it "returns the first invoice with a given created_at parameter" do
    get "/api/v1/invoices/find?created_at=#{@time}"
    invoice_json = JSON.parse(response.body)

    expect(invoice_json["id"]).to eql(@invoice_1.id)
    expect(invoice_json["status"]).to eql("limbo")
  end

  it "returns the first invoice with a given updated_at parameter" do
    get "/api/v1/invoices/find?updated_at=#{@time}"
    invoice_json = JSON.parse(response.body)

    expect(invoice_json["id"]).to eql(@invoice_1.id)
    expect(invoice_json["status"]).to eql("limbo")
  end

  it "returns an array with the correct invoice given an id parameter" do
    get "/api/v1/invoices/find_all?id=#{@invoice_1.id}"
    invoice_json = JSON.parse(response.body)

    expect(invoice_json).to be_a(Array)
    expect(invoice_json[0]).to be_a(Hash)
    expect(invoice_json[0]["id"]).to eql(@invoice_1.id)
    expect(invoice_json[0]["status"]).to eql("limbo")
  end

  it "returns all invoices with a specified status" do
    get "/api/v1/invoices/find_all?status=lImBo"
    invoice_json = JSON.parse(response.body)

    expect(invoice_json).to be_a(Array)
    expect(invoice_json.length).to eql(3)
    3.times do |i|
      expect(invoice_json[i]).to be_a(Hash)
      expect(invoice_json[i]["status"]).to eql("limbo")
    end
  end

  it "returns all invoices with a specified created_at parameter" do
    get "/api/v1/invoices/find_all?created_at=#{@time}"
    invoice_json = JSON.parse(response.body)

    expect(invoice_json.length).to eql(2)
    2.times do |i|
      expect(invoice_json[i]["status"]).to eql("limbo")
    end
  end

  it "returns all invoices with a specified updated_at parameter" do
    get "/api/v1/invoices/find_all?updated_at=#{@time}"
    invoice_json = JSON.parse(response.body)

    expect(invoice_json.length).to eql(2)
    2.times do |i|
      expect(invoice_json[i]["status"]).to eql("limbo")
    end
  end
end
