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

  def sociala_avgifter
    (self.bruttolon * self.soc_avgift_m_age).round
  end

  def soc_avgift_procent
    (self.soc_avgift_m_age * 100).round(2)
  end

  def soc_avgift_m_age
    if self.age < 25
      (self.soc_avgift - 0.043).round(5)
    elsif (25..64).include? self.age
      self.soc_avgift
    elsif self.age > 64
      (self.soc_avgift - 0.043).round(5)
    end
  end

  def pension_loneskatt
    if self.age < 25
      0
    elsif (25..64).include? self.age
      (0.2426 * (self.bruttolon * 0.043)).round
    elsif self.age > 64
      0
    end
  end

  def fakturabelopp
    (self.bruttolon + self.arbetsgivaravgifter + self.sociala_avgifter + self.pension_loneskatt).round
  end

  def fakturabelopp_inklmoms
    (self.fakturabelopp * 1.25).round
  end

  def fakturabelopp_frilansare
    (self.bruttolon + self.arbetsgivaravgifter).round
  end

  def varavgift
    (self.fakturabelopp_frilansare * self.user_fee).round
  end

  def bruttolon_ef_avg
    ((self.fakturabelopp_frilansare - self.varavgift) / (1 + self.a_g_avgift)).round
  end

  def arbetsgivaravgifter_ef_avg
    (self.bruttolon_ef_avg * self.a_g_avgift).round
  end

  def sociala_avgifter_ef_avg
    (self.bruttolon_ef_avg * self.soc_avgift_m_age).round
  end

  def semester_ers
    0.12
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
