class ChangeHourPerDayToBeStringInJobs < ActiveRecord::Migration[5.2]
  def change
    change_column :jobs, :hour_day, :string
  end
end
