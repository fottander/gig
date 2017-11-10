class Profile < ApplicationRecord
  validates_presence_of :username, :title, :description, :category, :city
  belongs_to :user
  has_many :applications, dependent: :destroy
  default_scope {order('created_at DESC')}
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment :avatar,
                        content_type:
                          {content_type: %w(image/jpg image/jpeg image/png image/gif)}

  scope :with_category, -> (category) { where category: category }

  def self.city
    ['Hela sverige', 'Göteborg', 'Malmö', 'Stockholm']
  end

  def self.category
    ['Målare', 'Snickare', 'Plåtslagare', 'Lagerarbetare']
  end

  self.per_page = 5
end
