class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :bank, :string
    add_column :users, :clear_nr, :string
    add_column :users, :account_nr, :string
    add_column :users, :pers_num, :string
  end
end
