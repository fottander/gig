class City < ApplicationRecord
  validates_presence_of :name
  has_and_belongs_to_many :profiles, dependent: :destroy
  has_and_belongs_to_many :jobs, dependent: :destroy
  default_scope {order('name ASC')}

  self.per_page = 4
end
