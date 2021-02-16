class Admin::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User successfully created"
      redirect_to admin_user_url(@user)
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def index
    @user = User.all
  end

  def def show
    @user = User.find()
  end

  private
    def user_params
      
    end

end
