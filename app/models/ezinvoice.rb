class Ezinvoice < ApplicationRecord
  before_create :generate_ocr
  before_validation :generate_ocr, on: :create
  validates_presence_of :description, :amount, :quantity, :unit, :user_reference, :org_number, :company_reference, :company_name, :company_address, :company_zip, :company_city, :company_email, :terms, :user_fee
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

  def nettolon
    (self.bruttolon_ef_avg - self.loneskatt).round
  end

  def loneskatt
    (self.bruttolon_ef_avg * self.inkomstskatt).round
  end

  def bruttolon
    (self.amount + (self.amount * self.semester_ers)).round
  end

  def arbetsgivaravgifter
    (self.bruttolon * self.a_g_avgift).round
  end

  def a_g_avgift
    0.3142
  end

  def fakturabelopp
    (self.bruttolon + self.arbetsgivaravgifter).round
  end

  def varavgift
    (self.fakturabelopp * self.user_fee).round
  end

  def bruttolon_ef_avg
    ((self.fakturabelopp - self.varavgift) / (1 + self.a_g_avgift)).round
  end

  def arbetsgivaravgifter_ef_avg
    (self.bruttolon_ef_avg * self.a_g_avgift).round
  end

  def semester_ers
    0.12
  end

  def fakturabelopp_inklmoms
    (self.fakturabelopp * 1.25).round
  end

  def due_date
    self.created_at + self.terms.day
  end

  def inkomstskatt
    0.3
  end

  private

  def generate_ocr
    self.ocr_number = Digest::SHA1.hexdigest([Time.now, rand].join)[0..10]
  end
end
