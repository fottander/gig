FactoryBot.define do
  factory :category do
    name "cat"
    ssyk_code "1212"
    avatar { File.new("#{Rails.root}/spec/images/Default-company.png") }
  end
end
