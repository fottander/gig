class AddAssociationApplicationToProfile < ActiveRecord::Migration[5.1]
  def change
    add_reference :profiles, :application, foreign_key: true
  end
end
