class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  has_one :profile, dependent: :destroy
  has_many :invoices
  has_many :ezinvoices
  secret_key = ENV['PERSNUM_KEY']
  attr_encrypted :pers_num, key: secret_key
  validates_length_of :pers_num, minimum: 10, maximum: 10, allow_blank: true
  before_save do
    self.pers_num = self.pers_num
  end

  default_scope {order('created_at DESC')}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :with_email, -> (email) { where email: email }
  scope :with_id, -> (id) { where id: id }
  scope :without_profile, -> { left_outer_joins(:profile).where(profiles: { id: nil }) }

  self.per_page = 10

  def rating_average
    self.invoices.with_rating.sum('rating')/self.invoices.with_rating.count
  end

  def total_earnings
    self.invoices.sum('amount') + self.ezinvoices.sum('amount')
  end

  def invoice_count
    self.invoices.count + self.ezinvoices.count
  end

  def fee
    if self.total_earnings < 10000
      0.1
    elsif (10000..20000).include? self.total_earnings
      0.09
    elsif (20001..50000).include? self.total_earnings
      0.08
    elsif (50001..100000).include? self.total_earnings
      0.07
    elsif (100001..250000).include? self.total_earnings
      0.06
    elsif (250001..500000).include? self.total_earnings
      0.05
    elsif self.total_earnings > 500000
      0.04
    end
  end

  def current_earnings
    if self.total_earnings < 10000
      '0 - 10 000 kr'
    elsif (10000..20000).include? self.total_earnings
      '10 000 - 20 000 kr'
    elsif (20001..50000).include? self.total_earnings
      '20 000 - 50 000 kr'
    elsif (50001..100000).include? self.total_earnings
      '50 000 - 100 000 kr'
    elsif (100001..250000).include? self.total_earnings
      '100 000 - 250 000 kr'
    elsif (250001..499999).include? self.total_earnings
      '250 000 - 500 000 kr'
    elsif self.total_earnings > 499999
      'Mer än 500 000 kr'
    end
  end
end
