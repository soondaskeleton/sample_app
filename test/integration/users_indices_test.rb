require 'rails_helper'

class UsersIndicesTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:soonie)
    @non_admin = users(:pitata)
  end

  test "index (#indices for #index) including pagination" do 
    log_in_as(@user)
    get users_indices_path
    assert_template 'users_indices'
    assert_select 'div.pagination'
    User.pagination(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end
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
    get users_indices_path
    assert_select 'a', text: 'delete', count: 0
  end
end

RSpec.describe "UsersIndices", type: :request do
  describe "GET /users_indices" do
    it "works! (now write some real specs)" do
      get users_indices_path
      expect(response).to have_http_status(200)
  end
end