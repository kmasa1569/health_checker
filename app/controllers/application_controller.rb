class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required
  include SessionsHelper

  private
    def current_user
      if (user_id = session[:user_id])
        @current_user ||= User.find_by(id: user_id)
      elsif (user_id = cookies.signed[:user_id])
        user = User.find_by(id: user_id)
        if user && user.authenticated?(cookies[:remember_token])
          log_in user
          @current_user = user
        end
      end
    end

    def login_required
      redirect_to root_url unless current_user
    end

    # ユーザーがログインしていればtrue、その他ならfalseを返す
    def logged_in?
      !current_user.nil?
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:id, :name, :email, :admin, :password, :password_confirmations, :dob, :sex)
    end

    # admin user以外禁
    def require_admin
      redirect_to root_url unless current_user.admin?
    end
end
