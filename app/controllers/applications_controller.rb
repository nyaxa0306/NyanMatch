class ApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_application, only:[:update_status]

  def index
    if current_user.protector?
      @applications = Application.joins(:cat).where(cats: { user_id: current_user.id }).includes(:user, :cat)
    else
      @applications = current_user.applications.includes(:cat).order(created_at: :desc)
    end
  end

  def create
    @application = Application.new(application_params)
    @application.user = current_user

    if @application.save
      redirect_to cat_path(@application.cat), notice: "応募が完了しました"
    else
      redirect_to cat_path(@application.cat), alert: "応募に失敗しました"
    end
  end

  def update_status
    if current_user.protector? && @application.cat.user_id == current_user.id
      @application.update(status: params[:status])
      redirect_to applications_path, notice: "ステータスを更新しました。"
    else
      redirect_to root_path, alert: "権限がありません。"
    end
  end
  private

  def application_params
    params.require(:application).permit(:cat_id, :message)
  end

  def set_application
    @application = Application.find(params[:id])
  end
end
