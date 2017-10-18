class Application < ApplicationRecord
  validates_presence_of :message
  has_one :profile
  belongs_to :job
end
