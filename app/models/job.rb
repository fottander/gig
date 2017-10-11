class Job < ApplicationRecord
  validates_presence_of :title, :description, :category, :city, :budget, :deadline, :duration, :hour_week
  belongs_to :company
end
