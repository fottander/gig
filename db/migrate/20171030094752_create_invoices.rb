class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.integer :quantity
      t.integer :unit
      t.integer :amount
      t.date :first_day
      t.date :last_day
      t.text :description
      t.string :ocr_number
      t.string :user_reference
      t.string :company_reference
      t.string :job_title
      t.float :user_fee
      t.text :feedback
      t.float :rating
      t.integer :terms, default: 15
      t.boolean :paid, default: false
      t.boolean :active, default: false
      t.boolean :salary_paid, default: false
      t.references :user, foreign_key: true
      t.references :company, foreign_key: true
      t.string :ssyk_code

      t.timestamps
    end
  end
end
