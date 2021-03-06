require "rails_helper"

describe Item do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:unit_price) }
    it { is_expected.to validate_presence_of(:merchant) }
  end

  scenario 'is valid when all fields are present' do
    merchant = create(:merchant)
    item = merchant.items.create(name: "Tshirt",
                                 description: "White short-sleeves",
                                 unit_price: 100)

    expect(item).to be_valid
  end

  scenario 'is invalid when name is blank' do
    merchant = create(:merchant)
    item = merchant.items.create(description: "White short-sleeves",
                                 unit_price: 100)

    expect(item).to be_invalid
  end

  scenario 'is invalid when description is blank' do
    merchant = create(:merchant)
    item = merchant.items.create(name: "Tshirt",
                                 unit_price: 100)

    expect(item).to be_invalid
  end

  scenario 'is invalid when unit price is blank' do
    merchant = create(:merchant)
    item = merchant.items.create(name: "Tshirt",
                                 description: "White short-sleeves")

    expect(item).to be_invalid
  end

  scenario 'is invalid when merchant is blank' do
    item = Item.create(name: "Tshirt",
                       description: "White short-sleeves",
                       unit_price: 100)

    expect(item).to be_invalid
  end

  context "associations" do
    it { is_expected.to belong_to(:merchant) }
    it { is_expected.to have_many(:invoice_items) }
    it { is_expected.to have_many(:invoices) }
  end
end
