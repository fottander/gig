class User < ApplicationRecord
  VALID_ROLES = ['company', 'person']
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :role, inclusion: {in: VALID_ROLES, message: '%{value} is not a valid user role'}

  def company?
    self.role == 'company'
  end
  def person?
    self.role == 'person'
  end
end
