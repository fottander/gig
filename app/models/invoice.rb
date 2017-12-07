class Invoice < ApplicationRecord
  before_create :generate_ocr
  validates_presence_of :description, :amount, :user_reference
  validates :amount, numericality: { only_integer: true }
  belongs_to :user
  belongs_to :company

  default_scope {order('created_at DESC')}
  scope :with_id, -> (id) { where id: id }
  scope :with_user_id, -> (user_id) { where user_id: user_id }
  scope :with_company_id, -> (company_id) { where company_id: company_id }
  scope :not_paid, -> { where(active: true, paid: false) }
  scope :paid, -> { where(active: true, paid: true) }

  self.per_page = 5

  private

  def generate_ocr
    self.ocr_number = Digest::SHA1.hexdigest([Time.now, rand].join)[0..10]
  end
end
