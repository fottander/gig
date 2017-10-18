class AddAssociationJobToApplication < ActiveRecord::Migration[5.1]
  def change
    add_reference :applications, :job, foreign_key: true
  end
end
