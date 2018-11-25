class RemoveFrilansarfakturaFromEzinvoice < ActiveRecord::Migration[5.2]
  def change
    remove_column :ezinvoices, :fakturabelopp_frilansare, :integer
  end
end
