class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_many :invoice
  default_scope {order('created_at DESC')}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :with_email, -> (email) { where email: email }
  scope :with_id, -> (id) { where id: id }
  scope :without_profile, -> { left_outer_joins(:profile).where(profiles: { id: nil }) }

  self.per_page = 10
end
