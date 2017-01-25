FactoryGirl.define do
  factory :item do
    name "Tshirt"
    description "White short-sleeve"
    unit_price 100
    merchant

    transient do
      invoice_items_count 3
    end

    factory :item_with_invoice_items do
      after(:create) do |item, evaluator|
        create_list(:invoice_item, evaluator.invoice_items_count, item: item)
      end
    end
  end
end
