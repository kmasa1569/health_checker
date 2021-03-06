class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @q = User.where(admin: false).ransack(params[:q])
    @users = @q.result
    @checklist = Checklist.where(params[:user_id])
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "#{@user.name} successfully updated"
    else
      flash.now[:alert] = "Something went wrong"
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "「#{@user.name}」is delete."
  end

  private
    
end
