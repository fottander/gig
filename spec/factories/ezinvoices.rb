FactoryGirl.define do
  factory :ezinvoice do
    org_number "MyString"
    company_name "MyString"
    company_address "MyString"
    company_zip 1
    company_city "MyString"
    company_email "MyString"
    description "MyText"
    quantity "MyString"
    unit "MyString"
    amount 1
    first_day "2018-01-10"
    last_day "2018-01-10"
    ocr_number "MyString"
    user_reference "MyString"
    company_reference "MyString"
    user_id 1
    profile_id 1
    profile_username "MyString"
    terms 1
    paid false
    active false
    salary_paid false
    post false
  end
end
