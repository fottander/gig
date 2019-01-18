class AddObToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :add_ob, :boolean, default: false
  end
end
