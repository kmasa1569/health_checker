class SessionsController < ApplicationController
  skip_before_action :login_required
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      log_in user
      #Sessionsヘルパーのrememberメソッド
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      - if current_user.admin?
          redirect_to admin_users_url, notice: 'ログインしました。'
        else
          redirect_to user_checklists_path(user), notice: 'ログインしました。'
        end
    else
      flash.now[:alert] = 'メールアドレス、もしくはパスワードが間違っています。'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path, notice: 'ログアウトしました。'
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
