require "rails_helper"

describe Item do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:unit_price) }
    it { is_expected.to validate_presence_of(:merchant) }
  end

  scenario 'is valid when all fields are present' do
    item = merchant.items.create(name: "Tshirt",
                                 description: "White short-sleeves",
                                 unit_price: 100)

    expect(item).to be_valid
  end

  scenario 'is invalid when name is blank' do
    item = merchant.items.create(description: "White short-sleeves",
                                 unit_price: 100)

    expect(item).to be_invalid
  end

  scenario 'is invalid when description is blank' do
    item = merchant.items.create(name: "Tshirt",
                                 unit_price: 100)

    expect(item).to be_invalid
  end

  scenario 'is invalid when unit price is blank' do
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
end
