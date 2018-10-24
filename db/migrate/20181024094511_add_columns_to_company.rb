class AddColumnsToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :description, :text
    add_column :companies, :employees, :string
  end
end
