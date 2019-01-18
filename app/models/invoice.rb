class Invoice < ApplicationRecord
  before_create :generate_ocr
  before_validation :generate_ocr, on: :create
  before_save :soc_avgift_m_age_gen, :bruttolon_gen, :arbetsgivaravgifter_gen, :sociala_avgifter_gen, :pension_loneskatt_gen, :fakturabelopp_gen, :varavgift_gen, :bruttol_exkl_semester_ef_avg_gen, :bruttolon_ef_avg_gen, :loneskatt_gen, :nettolon_gen, :arbetsgivaravgifter_ef_avg_gen, :sociala_avgifter_ef_avg_gen, :fakturabelopp_inklmoms_gen, :totalbelopp_gen, :totalbelopp_inklmoms_gen, :regenerate_values
  validates_presence_of :description, :amount, :quantity, :unit, :user_reference, :user_fee, :job_id, :job_title, :profile_id, :invoice_fees, :profile_username, :application_id, :terms
  validates :quantity, numericality: { only_float: true }, allow_blank: true
  validates :unit, numericality: { only_integer: true }, allow_blank: true
  validates :rating, numericality: { only_float: true }, allow_blank: true
  validates :amount, numericality: { only_integer: true }
  belongs_to :user
  belongs_to :company

  include PublicActivity::Common

  default_scope {order('created_at DESC')}
  scope :with_ocr, -> (ocr) { where ocr_number: ocr }
  scope :with_profile_id, -> (profile_id) { where profile_id: profile_id }
  scope :with_user_id, -> (user_id) { where user_id: user_id }
  scope :with_company_id, -> (company_id) { where company_id: company_id }
  scope :not_paid, -> { where(paid: false) }
  scope :paid, -> { where(paid: true) }
  scope :salary_paid, -> { where(salary_paid: true) }
  scope :salary_not_paid, -> { where(salary_paid: false) }
  scope :pay_day_reached, -> (selected_day) { where('"created_at" < ?', selected_day)}
  scope :with_feedback, -> { where.not(feedback: nil )}
  scope :with_rating, -> { where.not(rating: nil )}
  has_many :shifts, dependent: :destroy
  accepts_nested_attributes_for :shifts, allow_destroy: true, reject_if: proc { |attributes| attributes.any? {|k,v| v.blank?} }

  RATING_OPTIONS = [ "1", "2", "3", "4", "5" ]

  self.per_page = 4

  def due_date
    self.created_at + self.terms.day
  end

  def pay_day
    self.created_at + 30.day
  end

  def a_g_avgift
    0.3142
  end

  def soc_avgift_procent
    (self.soc_avgift_m_age * 100).round(2)
  end

  def semester_ers
    0.12
  end

  def inkomstskatt
    0.3
  end

  private

  def generate_ocr
    self.ocr_number = Digest::SHA1.hexdigest([Time.now, rand].join)[0..10]
  end

  def soc_avgift_m_age_gen
    if self.age < 25
      self.soc_avgift_m_age = (self.soc_avgift - 0.043).round(5)
    elsif (25..64).include? self.age
      self.soc_avgift_m_age = self.soc_avgift
    elsif self.age > 64
      self.soc_avgift_m_age = (self.soc_avgift - 0.043).round(5)
    end
  end

  def bruttolon_gen
    self.bruttolon = (self.amount + (self.amount * self.semester_ers)).round
  end

  def arbetsgivaravgifter_gen
    self.arbetsgivaravgifter = (self.bruttolon * self.a_g_avgift).round
  end

  def sociala_avgifter_gen
    self.sociala_avgifter = (self.bruttolon * self.soc_avgift_m_age).round
  end

  def pension_loneskatt_gen
    if self.age < 25
      self.pension_loneskatt = 0
    elsif (25..64).include? self.age
      self.pension_loneskatt = (0.2426 * (self.bruttolon * 0.043)).round
    elsif self.age > 64
      self.pension_loneskatt = 0
    end
  end

  def fakturabelopp_gen
    self.fakturabelopp = (self.bruttolon + self.arbetsgivaravgifter + self.sociala_avgifter + self.pension_loneskatt).round
  end

  def varavgift_gen
    self.varavgift = (self.amount * self.user_fee).round
  end

  def bruttol_exkl_semester_ef_avg_gen
    self.bruttol_exkl_semester_ef_avg = (self.amount - self.varavgift)
  end

  def bruttolon_ef_avg_gen
    self.bruttolon_ef_avg = (self.bruttol_exkl_semester_ef_avg * (1+self.semester_ers)).round
  end

  def loneskatt_gen
    self.loneskatt = (self.bruttolon_ef_avg * self.inkomstskatt).round
  end

  def nettolon_gen
    self.nettolon = (self.bruttolon_ef_avg - self.loneskatt).round
  end

  def arbetsgivaravgifter_ef_avg_gen
    self.arbetsgivaravgifter_ef_avg = (self.bruttolon_ef_avg * self.a_g_avgift).round
  end

  def sociala_avgifter_ef_avg_gen
    self.sociala_avgifter_ef_avg = (self.bruttolon_ef_avg * self.soc_avgift_m_age).round
  end

  def fakturabelopp_inklmoms_gen
    self.fakturabelopp_inklmoms = (self.fakturabelopp * 1.25).round
  end

  def totalbelopp_gen
    self.totalbelopp = (self.fakturabelopp + self.invoice_fees).round
  end

  def totalbelopp_inklmoms_gen
    self.totalbelopp_inklmoms = (self.totalbelopp * 1.25).round
  end

  def regenerate_values
    self.bruttolon = (self.amount + (self.amount * self.semester_ers)).round if amount_changed?
    self.arbetsgivaravgifter = (self.bruttolon * self.a_g_avgift).round if amount_changed?
    self.sociala_avgifter = (self.bruttolon * self.soc_avgift_m_age).round if amount_changed?
    if self.age < 25
      self.pension_loneskatt = 0
    elsif (25..64).include? self.age
      self.pension_loneskatt = (0.2426 * (self.bruttolon * 0.043)).round if amount_changed?
    elsif self.age > 64
      self.pension_loneskatt = 0
    end
    self.fakturabelopp = (self.bruttolon + self.arbetsgivaravgifter + self.sociala_avgifter + self.pension_loneskatt).round if amount_changed?
    self.varavgift = (self.amount * self.user_fee).round if amount_changed?
    self.bruttol_exkl_semester_ef_avg = (self.amount - self.varavgift) if amount_changed?
    self.bruttolon_ef_avg = (self.bruttol_exkl_semester_ef_avg * (1+self.semester_ers)).round if amount_changed?
    self.loneskatt = (self.bruttolon_ef_avg * self.inkomstskatt).round if amount_changed?
    self.nettolon = (self.bruttolon_ef_avg - self.loneskatt).round if amount_changed?
    self.arbetsgivaravgifter_ef_avg = (self.bruttolon_ef_avg * self.a_g_avgift).round if amount_changed?
    self.sociala_avgifter_ef_avg = (self.bruttolon_ef_avg * self.soc_avgift_m_age).round if amount_changed?
    self.fakturabelopp_inklmoms = (self.fakturabelopp * 1.25).round if amount_changed?
    self.totalbelopp = (self.fakturabelopp + self.invoice_fees).round if amount_changed? || invoice_fees_changed?
    self.totalbelopp_inklmoms = (self.totalbelopp * 1.25).round if amount_changed? || invoice_fees_changed?
  end

end
