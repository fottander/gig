class CreateJoinTableCityProfile < ActiveRecord::Migration[5.1]
  def change
    create_join_table :cities, :profiles do |t|
      # t.index [:category_id, :profile_id]
      # t.index [:profile_id, :category_id]
    end
  end
end
