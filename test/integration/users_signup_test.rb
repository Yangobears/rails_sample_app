require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: {name: "",
                                        email: "user@iii",
                                        password: "food",
                                        password_confirmation: "barr"}}
    end
    assert_template 'users/new'
    assert_select 'div.alert', "The form contains 4 errors."
  end


  test "valid signup information should persist to db" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {name: "yanyan",
                                        email: "user@iii.com",
                                        password: "foo12344",
                                        password_confirmation: "foo12344"}}
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end

end
