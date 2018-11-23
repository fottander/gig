FactoryBot.define do
  factory :profile do
    description "MyText"
    age "1988-09-14"
    avatar { File.new("#{Rails.root}/spec/images/Default-avatar.png") }
  end
end
