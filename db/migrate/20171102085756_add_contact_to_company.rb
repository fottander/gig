class AddContactToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :contact, :string
  end
end
