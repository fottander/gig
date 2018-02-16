class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :username
      t.string :title
      t.text :description
      t.string :skill

      t.timestamps
    end
  end
end
