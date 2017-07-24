require 'test_helper'
class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:furuhama) # fixtureで定義した:furuhama変数
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new' # 新しいsessionのフォームが表示されているか
    post login_path, params: {session: {email: "", password: ""}}
    assert_template 'sessions/new' # ログイン失敗時に新しいsessionsフォームが表示されているか
    assert_not flash.empty? # flashが正しく表示されているか
    get root_path
    assert flash.empty? # 一度表示されたflashが正しく消えているか
  end

  test "login with valid information" do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password'} }
    assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user) # これはどんなhtmlの内容を検証している？
  end
end
