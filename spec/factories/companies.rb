FactoryBot.define do
  factory :company do
    email "mail@mail.com"
    password "12345678"
    name "name"
    username "username"
    address "address"
    zip_code "zip code"
    city "city"
    org_number "org"
    phone "phoner"
    invoice_address "ohi"
    after(:create) { |c| c.confirm }
  end
end
