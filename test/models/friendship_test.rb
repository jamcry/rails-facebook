require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  def setup
    @friendship = Friendship.new(user: users(:test_user_1), friend: users(:test_user_2))
  end

  test "should be valid with user and friend" do
    assert @friendship.valid?
  end

  test "should require user_id" do
    @friendship.user_id = nil
    assert_not @friendship.valid?
  end

  test "should require friend_id" do
    @friendship.friend_id = nil
    assert_not @friendship.valid?
  end
end
