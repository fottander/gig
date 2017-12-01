class Invoice < ApplicationRecord
  validates_presence_of :description, :amount, :user_reference
  validates :amount, numericality: { only_integer: true }
  belongs_to :user
  belongs_to :company
  default_scope {order('created_at DESC')}

  scope :with_id, -> (id) { where id: id }
  scope :with_user_id, -> (user_id) { where user_id: user_id }
  scope :with_company_id, -> (company_id) { where company_id: company_id }

  self.per_page = 5
end
