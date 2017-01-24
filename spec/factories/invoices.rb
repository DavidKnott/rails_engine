FactoryGirl.define do
  factory :invoice do
    customer
    status "shipped"
    
  end
end
