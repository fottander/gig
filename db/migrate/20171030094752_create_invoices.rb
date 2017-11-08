class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.string :quantity
      t.string :unit
      t.integer :amount
      t.date :first_day
      t.date :last_day
      t.text :description
      t.string :user_reference
      t.string :company_reference
      t.integer :terms, default: 30
      t.boolean :paid, default: false
      t.boolean :active, default: false
      t.references :user, foreign_key: true
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
