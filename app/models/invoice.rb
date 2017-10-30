class Invoice < ApplicationRecord
  validates_presence_of :description, :amount, :user_reference
  belongs_to :application
end
