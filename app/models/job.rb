class Job < ApplicationRecord
  validates_presence_of :title, :description, :category_ids, :city_ids, :budget, :deadline, :duration, :hour_day, :when_in_time
  validates_length_of :title, maximum: 50
  belongs_to :company
  has_many :applications, dependent: :destroy
  has_and_belongs_to_many :categories, dependent: :destroy
  has_and_belongs_to_many :cities, dependent: :destroy
  default_scope {order('created_at DESC')}

  scope :with_category,  ->(category) { joins(:categories).where(categories: { name: category }) }
  scope :with_city,  ->(city) { joins(:cities).where(cities: { name: city }) }
  scope :with_id, -> (id) { where id: id }
  scope :active, -> { where active: true }
  scope :expired, -> { where('deadline >= ?', Date.today) }
  scope :with_company_id, -> (company_id) { where company_id: company_id }
  scope :with_company_username, -> (company_username) { where company_username: company_username }

  self.per_page = 10
end
