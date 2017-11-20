class CreateInvites < ActiveRecord::Migration[5.1]
  def change
    create_table :invites do |t|
      t.string :message
      t.string :job_title
      t.belongs_to :company, foreign_key: true

      t.timestamps
    end
  end
end
