class Company < ApplicationRecord
  validates_presence_of :name, :username, :email, :address, :zip_code, :city, :phone, :org_number, :contact
  has_many :jobs, dependent: :destroy
  has_many :invoices
  has_many :invites, dependent: :destroy
  default_scope {order('created_at DESC')}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :with_email, -> (email) { where email: email }
  scope :with_name, -> (name) { where name: name }

  self.per_page = 10
end
