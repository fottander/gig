class AddColumnsToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :soc_avgift, :float, default: 0.046
    add_column :invoices, :age, :integer
  end
end
