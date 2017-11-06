class Job < ApplicationRecord
  validates_presence_of :title, :description, :category, :city, :budget, :deadline, :duration, :hour_week
  belongs_to :company
  has_many :applications, dependent: :destroy
  default_scope {order('created_at DESC')}

  scope :with_category, -> (category) { where category: category }
  scope :expired, -> { where('deadline >= ?', Date.today) }

  def self.city
    ['Hela sverige', 'Göteborg', 'Malmö', 'Stockholm']
  end

  def self.category
    ['Målare', 'Snickare', 'Plåtslagare', 'Lagerarbetare']
  end

  self.per_page = 5
end
