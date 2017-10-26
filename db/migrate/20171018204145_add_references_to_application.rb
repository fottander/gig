class AddReferencesToApplication < ActiveRecord::Migration[5.1]
  def change
    add_column :applications, :profile_username, :string
    add_column :applications, :job_title, :string
    add_index :applications, :profile_username
    add_index :applications, :job_title
  end
end
