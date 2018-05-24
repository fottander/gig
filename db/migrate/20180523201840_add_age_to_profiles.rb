class AddAgeToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :age, :date
  end
end
