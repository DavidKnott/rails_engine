require "rails_helper"

describe Invoice do
  context 'validations' do
    it { is_expected.to validate_presence_of(:customer) }
    it { is_expected.to validate_presence_of(:status) }
  end

  scenario 'is valid when all fields are present' do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = customer.invoices.create(status: "shipped", merchant_id: merchant.id)

    expect(invoice).to be_valid
  end

  scenario 'is invalid when customer is blank' do
    invoice = Invoice.create(status: "shipped")

    expect(invoice).to be_invalid
  end

  scenario 'is invalid when status is blank' do
    customer = create(:customer)
    invoice = customer.invoices.create()

    expect(invoice).to be_invalid
  end

  context "associations" do
    it { is_expected.to belong_to(:customer) }
    it { is_expected.to belong_to(:merchant)}
    it { is_expected.to have_many(:invoice_items) }
    it { is_expected.to have_many(:items) }
  end
end
