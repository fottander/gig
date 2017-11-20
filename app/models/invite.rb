class Invite < ApplicationRecord
  validates_presence_of :message, :job_id
  belongs_to :company
  belongs_to :profile
  default_scope {order('created_at DESC')}

  self.per_page = 5
end
