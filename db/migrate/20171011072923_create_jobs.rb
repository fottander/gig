class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :requirement
      t.string :budget
      t.date :deadline
      t.string :when_in_time
      t.string :duration
      t.integer :hour_day
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
