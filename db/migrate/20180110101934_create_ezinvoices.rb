class CreateEzinvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :ezinvoices do |t|
      t.string :org_number
      t.string :company_name
      t.string :company_address
      t.integer :company_zip
      t.string :company_city
      t.string :company_email
      t.text :description
      t.integer :quantity
      t.integer :unit
      t.integer :amount
      t.date :first_day
      t.date :last_day
      t.float :user_fee
      t.string :ocr_number
      t.string :user_reference
      t.string :company_reference
      t.integer :profile_id
      t.string :profile_username
      t.integer :terms, default: 30
      t.boolean :paid, default: false
      t.boolean :active, default: false
      t.boolean :salary_paid, default: false
      t.boolean :post, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
