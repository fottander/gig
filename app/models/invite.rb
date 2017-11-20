class Invite < ApplicationRecord
  validates_presence_of :message, :job_id
  belongs_to :company
  belongs_to :profile
end
