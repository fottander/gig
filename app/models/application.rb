class Application < ApplicationRecord
  validate :last_day_a_first_day, on: :update
  belongs_to :profile
  belongs_to :job, touch: true
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

  def last_day_a_first_day
    if self.first_day.present?
      if self.last_day.present?
        if last_day < first_day
          errors.add(:last_day, "första dag måste vara innan sista dag")
        elsif last_day > first_day + 29.days
          errors.add(:last_day, 'för lång anställning')
        end
      end
    end
  end
end
