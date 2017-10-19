class AddReferenceToComment < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :profile_username, :string
    add_column :comments, :company_name, :string
    add_index :comments, :profile_username
    add_index :comments, :company_name
  end
end
