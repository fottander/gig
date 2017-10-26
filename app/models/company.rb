class Company < ApplicationRecord
  validates_presence_of :name, :username, :email, :address, :zip_code, :city, :phone, :org_number
  has_many :jobs, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
