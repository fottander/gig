FactoryGirl.define do
  factory :profile do
    username "MyString"
    title "MyString"
    description "MyText"
    avatar { File.new("#{Rails.root}/spec/images/Default-avatar.png") }
  end
end
