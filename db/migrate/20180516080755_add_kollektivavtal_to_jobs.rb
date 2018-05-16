class AddKollektivavtalToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :kollektivavtal, :boolean, default: false
  end
end
