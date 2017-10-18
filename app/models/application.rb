class Application < ApplicationRecord
  validates_presence_of :message
  belongs_to :profile
  belongs_to :job
end
