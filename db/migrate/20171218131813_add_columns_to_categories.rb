class AddColumnsToCategories < ActiveRecord::Migration[5.1]
  def up
    add_attachment :categories, :avatar
  end

  def down
    remove_attachment :categories, :avatar
  end
end
