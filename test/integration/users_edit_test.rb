require 'test_helper'
class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:furuhama)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template'users/edit'
    patch user_path(@user), params: { user: { name: "",
                                              email: "hoge@invalid",
                                              password: "fuga",
                                              password_confirmation: "piyo" } }
    assert_template 'users/edit'
    assert_select 'div.alert', /4/
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'hoge fuga'
    email = 'piyo@piyo.com'
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
