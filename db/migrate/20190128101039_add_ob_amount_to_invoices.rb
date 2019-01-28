class AddObAmountToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :ob_amount, :float, default: '0.0'
  end
end
