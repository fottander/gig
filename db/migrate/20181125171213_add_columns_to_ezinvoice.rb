class AddColumnsToEzinvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :ezinvoices, :nettolon, :integer
    add_column :ezinvoices, :loneskatt, :integer
    add_column :ezinvoices, :bruttolon, :integer
    add_column :ezinvoices, :arbetsgivaravgifter, :integer
    add_column :ezinvoices, :sociala_avgifter, :integer
    add_column :ezinvoices, :pension_loneskatt, :integer
    add_column :ezinvoices, :fakturabelopp, :integer
    add_column :ezinvoices, :fakturabelopp_frilansare, :integer
    add_column :ezinvoices, :varavgift, :integer
    add_column :ezinvoices, :bruttolon_ef_avg, :integer
    add_column :ezinvoices, :arbetsgivaravgifter_ef_avg, :integer
    add_column :ezinvoices, :sociala_avgifter_ef_avg, :integer
    add_column :ezinvoices, :fakturabelopp_inklmoms, :integer
    add_column :ezinvoices, :soc_avgift_m_age, :float
  end
end
