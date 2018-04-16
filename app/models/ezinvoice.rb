class Ezinvoice < ApplicationRecord
  before_create :generate_ocr
  before_validation :generate_ocr, on: :create
  validates_presence_of :description, :amount, :user_reference, :org_number, :company_reference, :company_name, :company_address, :company_zip, :company_city, :company_email, :terms, :user_fee
  validates :quantity, numericality: { only_integer: true }, allow_blank: true
  validates :unit, numericality: { only_integer: true }, allow_blank: true
  validates :amount, numericality: { only_integer: true }
  belongs_to :user

  default_scope {order('created_at DESC')}
  scope :with_ocr, -> (ocr) { where ocr_number: ocr }
  scope :with_user_id, -> (user_id) { where user_id: user_id }
  scope :not_paid, -> { where(paid: false) }
  scope :paid, -> { where(paid: true) }
  scope :salary_paid, -> { where(salary_paid: true) }
  scope :salary_not_paid, -> { where(salary_paid: false) }
  scope :pay_day_reached, -> (selected_day) { where('"created_at" < ?', selected_day)}

  self.per_page = 4

  def due_date
    self.created_at+self.terms.day
  end

  def inklmoms
    self.amount * 1.25
  end

  def a_g_avgift
    1.3142
  end

  def inkomstskatt
    0.3
  end

  def steg1
    self.amount * (1-self.user_fee)
  end

  def steg2
    self.steg1 / self.a_g_avgift
  end

  def steg3
    self.steg2 * (1-self.inkomstskatt)
  end

  def varavgift
    self.amount * self.user_fee
  end

  def arbetsgivaravgifter
    self.steg1 - (self.steg1 / self.a_g_avgift)
  end

  def bruttolon
    self.steg1 - self.arbetsgivaravgifter
  end

  def skatt
    self.bruttolon * self.inkomstskatt
  end

  private

  def generate_ocr
    self.ocr_number = Digest::SHA1.hexdigest([Time.now, rand].join)[0..10]
  end
end
