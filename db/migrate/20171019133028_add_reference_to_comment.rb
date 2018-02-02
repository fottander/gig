class AddReferenceToComment < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :profile_username, :string
    add_column :comments, :company_username, :string
  end
end
