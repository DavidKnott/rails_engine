FactoryGirl.define do
  factory :merchant do
    sequence :name do |n|
      "David#{n}"
    end

    transient do
      items_count 3
      invoices_count 3
    end

    factory :merchant_with_items do
      after(:create) do |merchant, evaluator|
        create_list(:item, evaluator.items_count, merchant: merchant)
      end
    end

    factory :merchant_with_invoices do
      after(:create) do |merchant, evaluator|
        create_list(:invoice, evaluator.invoices_count, merchant: merchant)
      end
    end

  end
end