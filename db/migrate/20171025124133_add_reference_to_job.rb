class AddReferenceToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :company_city, :string
    add_column :jobs, :company_username, :string
  end
end
