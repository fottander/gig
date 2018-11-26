class ChangeColumnTermsForInvoice < ActiveRecord::Migration[5.2]
  def change
    change_column :invoices, :terms, :integer, default: 10
    change_column :ezinvoices, :terms, :integer, default: 10
  end
end
