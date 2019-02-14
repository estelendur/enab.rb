require 'test_helper'

class UsersRegisterTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get register_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                           email: "user@invalid",
                                           password: "foo",
                                           password_confirmation: "bar" } }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get register_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Test User",
                                         email: "testuser1@example.com",
                                         password: "this is a password",
                                         password_confirmation: "this is a password" } }
    end
    follow_redirect!
    assert_template 'budget/index'
    assert is_logged_in?
  end
end
