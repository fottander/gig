class CreateApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :applications do |t|
      t.string :message
      t.boolean :status

      t.timestamps
    end
  end
end
