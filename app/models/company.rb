class Company < ApplicationRecord
  validates_presence_of :name, :username, :email, :address, :zip_code, :city, :phone, :org_number, :contact
  has_many :jobs, dependent: :destroy
  has_many :invoices
  has_many :invites, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id
  has_many :notices, foreign_key: :recipient_id
  default_scope {order('created_at DESC')}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :with_email, -> (email) { where email: email }
  scope :with_name, -> (name) { where name: name }
  scope :with_id, -> (id) { where id: id }

  self.per_page = 10

  def invoice_count
    self.invoices.count
  end
end
