class Admin::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_url, notice: "#{@user.name} successfully created"
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def index
    @users = User.all
  end

  def def show
    @user = User.find()
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :admin, :password, :password_confirmations)
    end

end
