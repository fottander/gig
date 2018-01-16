class AddUuidToInvoice < ActiveRecord::Migration[5.1]
  def up
    tables = [
      "invoices",
      "ezinvoices"
    ]

    tables.each do |table|
      add_column table, :uuid, :uuid, default: "uuid_generate_v4()", null: false
      remove_column table, :id
      rename_column table, :uuid, :id
      execute "ALTER TABLE #{table} ADD PRIMARY KEY (id);"
    end
  end
end
