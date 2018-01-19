class User < ApplicationRecord
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

  def total_earnings
    self.invoices.sum('amount') + self.ezinvoices.sum('amount')
  end

  def invoice_count
    self.invoices.count + self.ezinvoices.count
  end

  def fee
    if (self.total_earnings * 1.25) < 20000
      0.09
    elsif (20000..50000).include? (self.total_earnings * 1.25)
      0.08
    elsif (50001..100000).include? (self.total_earnings * 1.25)
      0.07
    elsif (100001..250000).include? (self.total_earnings * 1.25)
      0.06
    elsif (250001..500000).include? (self.total_earnings * 1.25)
      0.04
    elsif (self.total_earnings * 1.25) > 500000
      0.03
    end
  end
end
