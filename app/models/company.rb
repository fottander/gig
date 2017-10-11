class Company < ApplicationRecord
  validates_presence_of :name, :email, :address, :zip_code, :city, :phone, :org_number
  has_many :jobs
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
