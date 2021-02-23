class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      log_in user
      #Sessionsヘルパーのrememberメソッド
      remember user
      redirect_to admin_users_url, notice: 'ログインしました。'
    else
      flash.now[:alert] = 'メールアドレス、もしくはパスワードが間違っています。'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to login_path, notice: 'ログアウトしました。'
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
