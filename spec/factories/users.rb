FactoryBot.define do
  factory :user do
    email "mail@mail.com"
    password "12345678"
    after(:create) { |u| u.confirm }
  end
end
