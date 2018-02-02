class Ezinvoice < ApplicationRecord
  before_create :generate_ocr
  before_validation :generate_ocr, on: :create
  validates_presence_of :description, :amount, :user_reference, :org_number, :company_reference, :company_name, :company_address, :company_zip, :company_city, :company_email
  validates :amount, numericality: { only_integer: true }
  belongs_to :user

  default_scope {order('created_at DESC')}
  scope :with_ocr, -> (ocr) { where ocr_number: ocr }
  scope :with_user_id, -> (user_id) { where user_id: user_id }
  scope :not_paid, -> { where(active: true, paid: false) }
  scope :paid, -> { where(active: true, paid: true) }
  scope :active, -> { where(active: true) }
  scope :not_active, -> { where(active: false) }
  scope :salary_paid, -> { where(salary_paid: true) }
  scope :salary_not_paid, -> { where(salary_paid: false) }
  scope :pay_day, -> (selected_day) { where(updated_at: selected_day.to_date.beginning_of_day..selected_day.to_date.end_of_day)}

  self.per_page = 4

  def inklmoms
    self.amount * 1.25
  end

  def arbetsgivaravgift
    0.2391
  end

  def inkomstskatt
    0.3
  end

  def steg1
    self.amount * (1-self.user_fee)
  end

  def steg2
    self.steg1 * (1-self.arbetsgivaravgift)
  end

  def steg3
    self.steg2 * (1-self.inkomstskatt)
  end

  def varavgift
    self.amount * self.user_fee
  end

  def socialaavgifter
    self.steg1 * self.arbetsgivaravgift
  end

  def bruttolon
    self.steg1 - self.socialaavgifter
  end

  def skatt
    self.bruttolon * self.inkomstskatt
  end

  private

  def generate_ocr
    self.ocr_number = Digest::SHA1.hexdigest([Time.now, rand].join)[0..10]
  end
end
