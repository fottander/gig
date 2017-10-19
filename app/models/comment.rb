class Comment < ApplicationRecord
  validates_presence_of :comment

  belongs_to :application
  belongs_to :profile, optional: true
  belongs_to :company, optional: true
end
