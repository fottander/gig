class ChangeIntegerToFloatForInvoices < ActiveRecord::Migration[5.2]
  def self.up
    change_column :invoices, :quantity, :float
    change_column :ezinvoices, :quantity, :float
  end

  def self.down
    change_column :invoices, :quantity, :integer
    change_column :ezinvoices, :quantity, :integer
  end
end
