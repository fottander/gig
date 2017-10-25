class AddReferenceToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :company_city, :string
    add_column :jobs, :company_username, :string
    add_index :jobs, :company_city
    add_index :jobs, :company_username
  end
end
