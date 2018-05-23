class AddSocAvgiftToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :soc_avgift, :float, default: 0.0456
  end
end
