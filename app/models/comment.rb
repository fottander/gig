class Comment < ApplicationRecord
  validates_presence_of :comment
  belongs_to :application
  belongs_to :user, optional: true
  belongs_to :company, optional: true
end
