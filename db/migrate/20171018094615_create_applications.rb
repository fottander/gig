class CreateApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :applications do |t|
      t.string :message
      t.boolean :status, default: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
