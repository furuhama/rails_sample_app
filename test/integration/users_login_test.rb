require 'test_helper'
class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new' # 新しいsessionのフォームが表示されているか
    post login_path, params: {session: {email: "", password: ""}}
    assert_template 'sessions/new' # ログイン失敗時に新しいsessionsフォームが表示されているか
    assert_not flash.empty? # flashが正しく表示されているか
    get root_path
    assert flash.empty? # 一度表示されたflashが正しく消えているか
  end
end
