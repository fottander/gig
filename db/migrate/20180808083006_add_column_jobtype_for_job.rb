class AddColumnJobtypeForJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :jobtype, :string
  end
end
