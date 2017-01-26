FactoryGirl.define do
  factory :customer do
    first_name "Bob"
    last_name "Dylan"

    transient do
      invoices_count 3
      transactions_count 3
    end

    factory :customer_with_invoices do
      after(:create) do |customer, evaluator|
        create_list(:invoice, evaluator.invoices_count, customer: customer)
      end
    end

    factory :customer_with_invoices_with_transactions do
      after(:create) do |customer, evaluator|
        create_list(:invoice_with_transactions, evaluator.invoices_count, transactions_count: evaluator.transactions_count , customer: customer)
      end
    end
  end
end