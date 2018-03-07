FactoryGirl.define do
  factory :application do
    message "MyMessage"
    first_day "2017-10-30"
    last_day "2017-10-30"
    hired false
    complete false
  end
end
