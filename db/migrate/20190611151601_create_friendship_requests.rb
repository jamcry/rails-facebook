class CreateFriendshipRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friendship_requests do |t|
      t.integer :user_id
      t.integer :requested_user_id

      t.timestamps
    end
    add_index :friendship_requests, :user_id
    add_index :friendship_requests, :requested_user_id
    add_index :friendship_requests, [:user_id, :requested_user_id], unique: true
  end
end
