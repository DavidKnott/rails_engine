require "rails_helper"

describe "Top Customer for Merchant API" do
  before do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    other_customer = create(:customer)
    @favorite_customer = Customer.create!(first_name: "Caroline",
                                          last_name: "Powell")

    #create 2 successful invoices for favorite_customer for merchant 1
    #create 1 successful invoice and 2 unsuccessful invoices for other_customer for merchant 1
    #creaet 3 successful invoices for other_customer for merchant 2
    invoice_success_1 = @favorite_customer.invoices.create!(merchant: @merchant_1,
                                                            status: "shipped")
    invoice_success_2 = @favorite_customer.invoices.create!(merchant: @merchant_1,
                                                            status: "shipped")
    invoice_success_3 = other_customer.invoices.create!(merchant: @merchant_1,
                                                        status: "shipped")
    invoice_failed_1 = other_customer.invoices.create!(merchant: @merchant_1,
                                                        status: "shipped")
    invoice_failed_2 = other_customer.invoices.create!(merchant: @merchant_1,
                                                        status: "shipped")
    invoice_success_4 = other_customer.invoices.create!(merchant: @merchant_2,
                                                            status: "shipped")
    invoice_success_5 = other_customer.invoices.create!(merchant: @merchant_2,
                                                            status: "shipped")
    invoice_success_6 = other_customer.invoices.create!(merchant: @merchant_2,
                                                            status: "shipped")

    #create transactions for the invoices
    invoice_success_1.transactions.create!(credit_card_number: "1111222233334444",
                                          result: "success")
    invoice_success_2.transactions.create!(credit_card_number: "1111222233334444",
                                          result: "success")
    invoice_success_3.transactions.create!(credit_card_number: "1111222233334444",
                                              result: "success")
    invoice_failed_1.transactions.create!(credit_card_number: "1111222233334444",
                                              result: "failed")
    invoice_failed_2.transactions.create!(credit_card_number: "1111222233334444",
                                              result: "failed")
    invoice_success_4.transactions.create!(credit_card_number: "1111222233334444",
                                              result: "success")
    invoice_success_5.transactions.create!(credit_card_number: "1111222233334444",
                                              result: "success")
    invoice_success_6.transactions.create!(credit_card_number: "1111222233334444",
                                              result: "success")
  end

  it "returns the customer with the highest count of successful transactions" do
    get "/api/v1/merchants/#{@merchant_1.id}/favorite_customer"
    customer_json = JSON.parse(response.body)

    expect(customer_json["id"]).to eql(@favorite_customer.id)
    expect(customer_json["first_name"]).to eql("Caroline")
    expect(customer_json["last_name"]).to eql("Powell")
  end
end
