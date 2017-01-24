FactoryGirl.define do
  factory :invoice_item do
    item
    invoice
    quantity 2
    unit_price 100
  end
end
