class AddColumnsToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :nettolon, :integer
    add_column :invoices, :loneskatt, :integer
    add_column :invoices, :bruttolon, :integer
    add_column :invoices, :arbetsgivaravgifter, :integer
    add_column :invoices, :sociala_avgifter, :integer
    add_column :invoices, :pension_loneskatt, :integer
    add_column :invoices, :fakturabelopp, :integer
    add_column :invoices, :fakturabelopp_frilansare, :integer
    add_column :invoices, :varavgift, :integer
    add_column :invoices, :bruttolon_ef_avg, :integer
    add_column :invoices, :arbetsgivaravgifter_ef_avg, :integer
    add_column :invoices, :sociala_avgifter_ef_avg, :integer
    add_column :invoices, :fakturabelopp_inklmoms, :integer
    add_column :invoices, :totalbelopp, :integer
    add_column :invoices, :totalbelopp_inklmoms, :integer
  end
end
