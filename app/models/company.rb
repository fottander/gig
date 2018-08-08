class Company < ApplicationRecord
  validates_presence_of :name, :address, :zip_code, :city, :phone, :org_number
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  has_many :jobs, dependent: :destroy
  has_many :invoices
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
