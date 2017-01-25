FactoryGirl.define do
  factory :invoice do
    customer
    status "shipped"

    transient do
      transactions_count 3
    end

    factory :invoice_with_transactions do
      after(:create) do |invoice, evaluator|
        create_list(:transaction, evaluator.transactions_count, invoice: invoice)
      end
    end
  end



end
