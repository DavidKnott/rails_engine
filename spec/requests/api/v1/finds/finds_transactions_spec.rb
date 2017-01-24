require 'rails_helper'

describe "Finds Transactions API" do
  it "returns a single transaction matching the given attribute" do
    create(:transaction, credit_card_number: 12345)
    create_list(:transaction, 10)

    get "api/v1/transactions/find?credit_card_number=12345"

    transaction = JSON.parse(response.body)
    expected_card_number = Transaction.find_by(credit_card_number: 12345).credit_card_number

    expect(response).to be_success
    expect(transaction).to have_key "id"
    expect(transaction).to have_key "credit_card_number"
    expect(transaction["credit_card_number"]).to eq expected_card_number
    expect(transaction).to have_key "result"
    expect(transaction).to have_key "created_at"
    expect(transaction).to have_key "updated_at"
  end
end