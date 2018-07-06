class RemoveKollektivavtalFromJobs < ActiveRecord::Migration[5.1]
  def change
    remove_column :jobs, :kollektivavtal, :string
  end
end
