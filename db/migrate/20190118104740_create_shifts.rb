class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.references :invoice, type: :uuid

      t.timestamps
    end
  end
end
