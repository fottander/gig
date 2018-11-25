class AddColumnToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :soc_avgift_m_age, :float
  end
end
