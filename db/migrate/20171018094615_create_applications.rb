class CreateApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :applications do |t|
      t.string :message
      t.boolean :hired, default: false
      t.boolean :complete, default: false

      t.timestamps
    end
  end
end
