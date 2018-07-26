class ChangeDefaultValueForInvoices < ActiveRecord::Migration[5.1]
  def up
    change_column_default :invoices, :invoice_fees, 199
  end

  def down
    change_column_default :invoices, :invoice_fees, 0
  end
end
