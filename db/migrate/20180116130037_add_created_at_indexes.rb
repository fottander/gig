class AddCreatedAtIndexes < ActiveRecord::Migration[5.1]
  def up
    add_index :invoices, :created_at
    add_index :ezinvoices, :created_at
  end
end
