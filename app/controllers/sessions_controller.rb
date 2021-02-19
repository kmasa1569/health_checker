class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      # redirect_to root_url, notice: 'ログインしました。'
    else
      render :new
      # flash.now[:dangers] = 'メールアドレス、もしくはパスワードが間違っています。'
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: 'ログアウトしました。'
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
