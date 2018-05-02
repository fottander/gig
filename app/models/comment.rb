class Comment < ApplicationRecord
  validates_presence_of :comment
  belongs_to :application
  belongs_to :profile, optional: true, touch: true
  belongs_to :company, optional: true
  default_scope {order('created_at DESC')}
  
  include PublicActivity::Common

end
