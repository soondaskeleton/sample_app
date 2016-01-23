require 'rails_helper'

class UsersIndicesTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:soonie)
    @non_admin = users(:pitata)
  end

  test "index (#indices for #index) including pagination" do 
    log_in_as(@admin)
    get users_indices_path
    assert_template 'users/indices'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do 
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do 
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end