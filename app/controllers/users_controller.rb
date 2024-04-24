class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :require_login, only: %i[show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, success: '登録に成功しました'
    else
      flash.now[:alert] = '登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.friendly.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
