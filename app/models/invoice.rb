class Invoice < ApplicationRecord
  validates_presence_of :description, :amount, :user_reference
  validates :amount, numericality: { only_integer: true }
  belongs_to :user
  belongs_to :company
  default_scope {order('created_at DESC')}
end
