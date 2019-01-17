class AddObToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :add_ob, :boolean, default: false
  end
end
