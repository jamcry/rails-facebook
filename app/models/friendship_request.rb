class FriendshipRequest < ApplicationRecord
  belongs_to :user
  belongs_to :requested_user, class_name: "User"

  def accept
    requested_user.make_friends_with(user) #if requested_user == current_user
  end
end
