class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save && @user.admin == true
      redirect_to admin_users_path, notice: "「#{@user.name}」 successfully created"
    elsif @user.save && @user.admin == false
      redirect_to users_path, notice: "「#{@user.name}」 successfully created"
    else
      flash.now[:alert] = "Something went wrong"
      render :new
    end
  end

  def index
    @q = User.where(admin: true).ransack(params[:q])
    @admin_users = @q.result
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "#{@user.name} successfully updated"
    else
      flash.now[:alert] = "Something went wrong"
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "「#{@user.name}」is delete."
  end

  private

end
