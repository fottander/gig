FactoryGirl.define do
  factory :notice do
    recipient_id 1
    actor_id 1
    action "MyString"
    job_id 1
    application_id 1
    notifiable_id 1
    notifiable_type "MyString"
  end
end
