require 'test_helper'
class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:furuhama)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template'users/edit'
    patch user_path(@user), params: { user: { name: "",
                                              email: "hoge@invalid",
                                              password: "fuga",
                                              password_confirmation: "piyo" } }
    assert_template 'users/edit'
    assert_select 'div.alert', /4/
  end
end
