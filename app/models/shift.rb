class Shift < ApplicationRecord
  validates_presence_of :start_date, :end_date, :start_time, :end_time
  belongs_to :invoice
end
