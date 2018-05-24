FactoryGirl.define do
  factory :profile do
    title "MyString"
    description "MyText"
    avatar { File.new("#{Rails.root}/spec/images/Default-avatar.png") }
  end
end
