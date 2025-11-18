class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_user
  before_action :authorize_user, only: [:edit_profile, :update]

  def show
  end

  def edit_profile
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "プロフィールを更新しました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit_profile, status: :unprocessable_entity
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    redirect_to root_path, alert: "権限がありません" unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:nickname, :role, :introduction)
  end
end
