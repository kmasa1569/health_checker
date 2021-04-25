class PasswordResetsController < ApplicationController
  skip_before_action :login_required
  before_action :set_user,   only: [:edit, :update]
  # before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "メールを送信しました"
      redirect_to root_url
    else
      flash.now[:danger] = "メールアドレスが見つかりません"
      render 'new'
    end
  end

  def edit
    @user = User.find_by(email: params[:email])
  end

  def update
    @user = User.find_by(email: params[:email])
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank) #エラーメッセージの追加
      render 'edit'
    elsif @user.update(user_params) #更新する
      log_in @user
      flash[:success] = "パスワードをリセットしました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def set_user
      @user = User.find_by(email: params[:email])
    end

    # 正しいユーザーかどうか確認する
    def valid_user
      unless (@user && @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    # トークンが期限切れかどうか確認する
    def check_expiration
      # binding.pry
      if @user.password_reset_expired?
        flash[:danger] = "パスワードのリセット期限が切れています"
        redirect_to new_password_reset_url
      end
    end
end
