require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Can create authentication and user" do
  	authentication = build(:twitter)
  	assert authentication.valid?, "Authentication isn't valid: " + authentication.errors.full_messages.to_s

  	user = build(:user)

  	user.authentications.push authentication
  	assert user.valid?, "User isn't valid: " + user.errors.full_messages.to_s
  end

end
