FactoryGirl.define do
  factory :merchant do
    sequence :name do |n|
      "David#{n}"
    end
  end
end