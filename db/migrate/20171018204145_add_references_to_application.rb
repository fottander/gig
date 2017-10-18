class AddReferencesToApplication < ActiveRecord::Migration[5.1]
  def change
    add_column :applications, :profile_username, :string
    add_index :applications, :profile_username
  end
end
