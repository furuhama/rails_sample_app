require 'test_helper'
class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: "",
                                         email: "user@invalid",
                                         password: "hoge",
                                         password_comfirmation: "fuga" }}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert' # この指定方法いまいち理解できてない
    assert_select 'form[action = "/signup"]'
  end
end
