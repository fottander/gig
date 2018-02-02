class AddReferencesToApplication < ActiveRecord::Migration[5.1]
  def change
    add_column :applications, :profile_username, :string
    add_column :applications, :job_title, :string
    add_column :applications, :company_id, :integer
  end
end
