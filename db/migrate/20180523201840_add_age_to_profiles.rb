class AddAgeToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :age, :date, default: "1995-05-05"
  end
end
