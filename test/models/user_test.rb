require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(first_name: "Test", surname: "User", password: "foobar",
                        email: "text@example.com", birthday: Date.new, gender_id: 1)
  end

  test "all fields should be present" do
    user = User.new
    user.first_name = "First Name"
    assert_not user.valid?
    user.surname = "Surname"
    assert_not user.valid?
    user.password = "foobar"
    assert_not user.valid?
    user.email = "test@example.com"
    assert_not user.valid?
    user.birthday = Date.new
    assert_not user.valid?
    user.gender_id = 1
    assert user.valid?
  end

  test "#gender returns the gender text" do
    assert_equal @user.gender, "Female"
    @user.gender_id = 0
    assert_equal @user.gender, "Male"
  end

end
