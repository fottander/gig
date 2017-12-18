FactoryGirl.define do
  factory :category do
    name "cat"
    avatar { File.new("#{Rails.root}/spec/images/Default-company.png") }
  end
end
