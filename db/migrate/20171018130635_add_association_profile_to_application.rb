class AddAssociationProfileToApplication < ActiveRecord::Migration[5.1]
  def change
    add_reference :applications, :profile, foreign_key: true
  end
end
