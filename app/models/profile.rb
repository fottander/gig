class Profile < ApplicationRecord
  validates_presence_of :username, :description, :category, :city
  belongs_to :user
  has_many :applications, dependent: :destroy
end
