FactoryGirl.define do
  factory :transaction do
    sequence :credit_card_number do |n|
      12345678 + n
    end
    result "success"
    invoice
  end
end