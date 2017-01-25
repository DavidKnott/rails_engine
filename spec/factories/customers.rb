FactoryGirl.define do
  factory :customer do
    first_name "Bob"
    last_name "Dylan"

    transient do
      invoice_count 3
    end

    factory :customer_with_invoices do
      after(:create) do |customer, evaluator|
        create_list(:invoice, evaluator.invoice_count, customer: customer)
      end
    end
  end
end