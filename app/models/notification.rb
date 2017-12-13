class Notification < ApplicationRecord
  validates_presence_of :recipient_id, :actor_id, :job_id, :action, :notifiable_type
  belongs_to :recipient, class_name: 'Company'
  belongs_to :actor, class_name: 'Profile'
  belongs_to :notifiable, polymorphic: true
  default_scope {order('created_at DESC')}
end
