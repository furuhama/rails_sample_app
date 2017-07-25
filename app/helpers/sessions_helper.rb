module SessionsHelper
  # 渡されたuserでログインを行う
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 現在ログイン中のユーザーを返す(いる場合)
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ユーザーがログインしていればtrue, それ以外ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
