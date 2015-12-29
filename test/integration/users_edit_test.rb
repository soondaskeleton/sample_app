require 'test_helper'

class UsersEdits < ActionDispatch::IntegrationTest

  test "unsuccessful edit" do 
    log_in_as(@user)
    get users_edits_path(@user)
    end

  test "successful edit" do 
    lgin_in_as(@user)
    get users_edits_path(@user)
  end

  test "should edit with friendly forwarding" do 
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), user: { name: name, email: email, password: "", password_confirmation: ""}
    assert_not flash.empty?
    assert_redirected_to @users_edits_path
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end