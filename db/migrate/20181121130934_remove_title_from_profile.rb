class RemoveTitleFromProfile < ActiveRecord::Migration[5.2]
  def change
    remove_column :profiles, :title, :string
  end
end
