class AddAssociationJobToInvite < ActiveRecord::Migration[5.1]
  def change
    add_reference :invites, :profile, foreign_key: true
  end
end
