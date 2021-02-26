module SessionsHelper
  # 渡されたユーザーでcookieを使ってログイン
  def log_in(user)
    session[:user_id] = user.id
  end

  # ユーザーのセッションを永続的にする
  def remember(user)
    user.remember #Userモデルで定義したremember。トークンとユーザーを紐付け、記憶ダイジェストをDB保存
    # 署名付きcookie,permanentは期限を20年にする
    cookies.permanent.signed[:user_id] = user.id #ユーザーID暗号化しcookie保存
    cookies.permanent[:remember_token] = user.remember_token #記憶トークンをcookie保存
  end

  # ユーザーのログイン情報を破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

end
