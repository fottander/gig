class AddReferenceToInvoice < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :application_id, :integer
    add_column :invoices, :job_id, :integer
    add_column :invoices, :profile_id, :integer
    add_column :invoices, :profile_username, :string
  end
end
