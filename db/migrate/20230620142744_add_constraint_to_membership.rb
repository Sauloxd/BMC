class AddConstraintToMembership < ActiveRecord::Migration[7.0]
  def change
    add_index :memberships, [:user_id, :club_id], unique: true
  end
end
