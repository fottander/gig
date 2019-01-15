class AddOrderNumberToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :order_number, :integer
  end
end
