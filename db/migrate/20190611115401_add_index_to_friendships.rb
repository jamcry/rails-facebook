class AddIndexToFriendships < ActiveRecord::Migration[5.2]
  def change
    remove_index :friendships, [:user_id, :friend_id]
    add_index    :friendships, [:user_id, :friend_id], unique: true
  end
end
