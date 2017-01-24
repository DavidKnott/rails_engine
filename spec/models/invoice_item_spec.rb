require "rails_helper"

describe InvoiceItem do
  context 'validations' do
    it { is_expected.to validate_presence_of(:item) }
    it { is_expected.to validate_presence_of(:invoice) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:unit_price) }
    it { should validate_uniqueness_of(:item).scoped_to(:invoice) }
  end

  scenario 'is valid when all fields are present' do
    item = create(:item)
    invoice = create(:invoice)
    invoice_item = item.invoice_items.create(invoice: invoice,
                                             quantity: 2,
                                             unit_price: 100)

    expect(item).to be_valid
  end

  scenario 'is invalid when item is blank' do
    invoice = create(:invoice)
    invoice_item = InvoiceItem.create(invoice: invoice,
                                       quantity: 2,
                                       unit_price: 100)

    expect(item).to be_invalid
  end

  scenario 'is invalid when invoice is blank' do
    item = create(:item)
    invoice_item = item.invoice_items.create(quantity: 2,
                                             unit_price: 100)

    expect(item).to be_invalid
  end

  scenario 'is invalid when quantity is blank' do
    item = create(:item)
    invoice = create(:invoice)
    invoice_item = item.invoice_items.create(invoice: invoice,
                                             unit_price: 100)

    expect(item).to be_invalid
  end

  scenario 'is invalid when unit_price is blank' do
    item = create(:item)
    invoice = create(:invoice)
    invoice_item = item.invoice_items.create(invoice: invoice,
                                              quantity: 2)

    expect(item).to be_invalid
  end

  context "associations" do
    it { is_expected.to belong_to(:item) }
    it { is_expected.to belong_to(:invoice) }
  end
end
