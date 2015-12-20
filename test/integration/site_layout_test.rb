require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
test "layout links" do   # test "the truth" do
  get root_path
  assert_template 'static_pages/home' #   assert true
  assert_select "a[href=?]", root_path, count: 2 # end
  assert_select "a[href=?]", help_path
  assert_select "a[href=?]", about_path
  assert_select "a[href=?]", contact_path
  get signup_path
  assert_select "title", full_title("Signup up")
  end
end