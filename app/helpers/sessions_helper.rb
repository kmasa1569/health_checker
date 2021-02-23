module SessionsHelper
  # 渡されたユーザーでcookieを使ってログイン
  def log_in(user)
    session[:user_id] = user.id
  end

  # ユーザーのセッションを永続的にする
  def remember(user)
    user.remember
    # 署名付きcookie,permanentは期限を20年にする
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # ユーザーのログイン情報を破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget.current_user
    reset_session
    @current_user = nil
  end

end
