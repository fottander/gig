class Profile < ApplicationRecord
  validates_presence_of :username, :description, :category, :city
  belongs_to :user
end
