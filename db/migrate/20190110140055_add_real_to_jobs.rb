class AddRealToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :real, :boolean, default: true
  end
end
