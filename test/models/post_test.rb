require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:test_user_1)
    @post = @user.posts.build(body: "Example post body")
  end

  test "post with body should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user = nil
    assert_not @post.valid?
  end

  test "body should be present" do
    @post.body = "   "
    assert_not @post.valid?
  end

  test "post's comments should be destroyed with post" do
    @post.save
    @post.comments.build(body: "Example first comment body", user: @user)
    @post.comments.build(body: "Example second comment body", user: @user)
    difference_amount = -(@post.comments.count)
    assert_difference 'Comment.count', difference_amount do
      @post.destroy
    end
  end
end
