class AddColumnsToJobs < ActiveRecord::Migration[5.1]
  def up
    add_attachment :jobs, :avatar
  end

  def down
    remove_attachment :jobs, :avatar
  end
end
