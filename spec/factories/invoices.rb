FactoryGirl.define do
  factory :invoice do
    quantity 1
    unit 1
    amount "MyString"
    first_day "2017-10-30"
    last_day "2017-10-30"
    description "MyText"
    user_reference "MyString"
    company_reference "MyString"
  end
end
