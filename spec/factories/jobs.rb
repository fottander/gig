FactoryGirl.define do
  factory :job do
    title "Mytitle"
    description "Mydesc"
    requirement "Myreq"
    category "Mycat"
    city "Mycity"
    budget "Mybudget"
    deadline "2017-10-11"
    duration "Mydur"
    hour_week 1
    active true
  end
end
