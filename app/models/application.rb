class Application < ApplicationRecord
  validates_presence_of :message
  belongs_to :profile
  belongs_to :job
  has_many :comments, dependent: :destroy
  has_one :company, through: :comments

  include PublicActivity::Common

  scope :with_id, -> (id) { where id: id }
  scope :with_job_id, -> (job_id) { where job_id: job_id }
  scope :with_profile_id, -> (profile_id) { where profile_id: profile_id }
  scope :expired, -> { where('updated_at <= ?', Date.today-60.days) }
  scope :hired, -> { where(complete: false, hired: true) }
  scope :complete, -> { where(complete: true, hired: true) }
  scope :not_hired, -> { where(hired: false) }

  self.per_page = 4
end
