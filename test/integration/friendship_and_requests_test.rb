require 'test_helper'

class FriendshipAndRequestsTestTest < ActionDispatch::IntegrationTest
  def setup
    @user1 = User.create!(first_name: "First", surname: "Tester", password: "foobar", email: "first@tester.com", birthday: Date.new, gender_id: 0)
    @user2 = User.create!(first_name: "Second", surname: "Tester", password: "foobar", email: "second@tester.com", birthday: Date.new, gender_id: 0)
  end

  test "sending friendship requests" do
    assert_not @user1.friends_with? @user2
    request = @user1.send_friendship_request(@user2)
    assert_equal @user1.friendship_requests.last, request
    assert @user1.pending_friends.include? @user2
    assert_equal @user2.recieved_requests.last, request
  end
end
