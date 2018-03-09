FactoryGirl.define do
  factory :invoice do
    quantity 123
    unit 123
    amount 12345
    first_day "2017-10-30"
    last_day "2017-10-30"
    description "MyText"
    user_reference "MyString"
    company_reference "MyString"
    ocr_number "MyString"
    user_fee 0.1
    job_id 1
    application_id 1
    job_title "MyString"
    ssyk_code "MyString"
    profile_id 1
    profile_username "MyString"
  end
end
