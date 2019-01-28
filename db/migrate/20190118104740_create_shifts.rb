class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.float :quantity
      t.float :ob_amount
      t.date :start_date
      t.date :end_date
      t.datetime :start_time
      t.datetime :end_time
      t.references :invoice, type: :uuid

      t.timestamps
    end
  end
end
