class AddRealToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :real, :boolean, default: true
  end
end
