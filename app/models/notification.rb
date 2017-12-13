class Notification < ApplicationRecord
  belongs_to :recipient, class_name: 'Company'
  belongs_to :actor, class_name: 'Profile'
  belongs_to :notifiable, polymorphic: true
end
