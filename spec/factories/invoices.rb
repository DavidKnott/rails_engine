FactoryGirl.define do
  factory :invoice do
    customer
    status "shipped"
    merchant

    transient do
      transactions_count 3
      invoice_items_count 3
    end

    factory :invoice_with_transactions do
      after(:create) do |invoice, evaluator|
        create_list(:transaction, evaluator.transactions_count, invoice: invoice)
      end
    end

    factory :invoice_with_invoice_items do
      after(:create) do |invoice, evaluator|
        create_list(:invoice_item, evaluator.invoice_items_count, invoice: invoice)
      end
    end

  end



end
