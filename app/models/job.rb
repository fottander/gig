class Job < ApplicationRecord
  validates_presence_of :title, :description, :category, :city, :budget, :deadline, :duration, :hour_week, :active
  belongs_to :company
end
