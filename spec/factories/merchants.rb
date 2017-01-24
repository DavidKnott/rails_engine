FactoryGirl.define do
  factory :merchant do
    sequence :name do |n|
      "David#{n}"
    end
  end

  factory :merchant_with_items do
    after(:create) do |merchant|
      create_list(:item, 6, merchant: merchant)
    end
  end
end