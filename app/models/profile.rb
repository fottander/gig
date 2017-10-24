class Profile < ApplicationRecord
  validates_presence_of :username, :description, :category, :city
  belongs_to :user
  has_many :applications, dependent: :destroy

  scope :with_category, -> (category) { where category: category }

  def self.city
    ['Hela sverige', 'Göteborg', 'Malmö', 'Stockholm']
  end

  def self.category
    ['Målare', 'Snickare', 'Plåtslagare', 'Lagerarbetare']
  end
end
