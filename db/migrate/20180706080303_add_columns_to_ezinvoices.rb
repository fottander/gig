class AddColumnsToEzinvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :ezinvoices, :soc_avgift, :float, default: 0.046
    add_column :ezinvoices, :age, :integer
  end
end
