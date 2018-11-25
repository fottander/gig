class RemoveFrilansarfakturaFromInvoice < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoices, :fakturabelopp_frilansare, :integer
  end
end
