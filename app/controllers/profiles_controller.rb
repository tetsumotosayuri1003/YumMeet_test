class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update show]

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: '更新できました'
    else
      flash.now['alert'] = '更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @user_boards = @user.boards.includes(:user).order(created_at: :desc)
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :avatar, :avatar_cache)
  end
end
