class Admin::UsersController < ApplicationController
  before_action :require_admin
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_url, notice: "#{@user.name} successfully created"
    else
      flash.now[:alert] = "Something went wrong"
      render :new
    end
  end

  def index
    @q = MedicalStaff.ransack(params[:q])
    @medical_staffs = @q.result
  end

  def index_p
    @q = Patient.ransack(params[:q])
    @patients = @q.result
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_url, notice: "#{@user.name} successfully updated"
    else
      flash[:error] = "Something went wrong"
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "「#{@user.name}」is delete."
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :admin, :password, :password_confirmations, :type)
    end

    # admin user以外禁
    def require_admin
      redirect_to root_url unless current_user.admin?
    end

end
