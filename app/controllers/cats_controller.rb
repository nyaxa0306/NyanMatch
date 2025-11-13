class CatsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_cat, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @cats = Cat.includes(:user).order(created_at: :desc)
  end

  def show
  end

  def new
    @cat = current_user.cats.build
  end

  def create
    @cat = current_user.cats.build(cat_params)
    if @cat.save
      redirect_to @cat, notice: "猫ちゃんを登録しました"
    else
      flash.now[:alert] = "登録に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @cat.update(cat_params)
      redirect_to @cat, notice: "猫ちゃんの情報を更新しました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @cat.destroy
    redirect_to cats_path, alert: "猫ちゃんの情報を削除しました"
  end

  private

  def set_cat
    @cat = Cat.find(params[:id])
  end

  def authorize_user!
    unless @cat.user == current_user || current_user.role == "protecter"
      redirect_to cats_path, alert: "権限がありません"
    end
  end

  def cat_params
    params.require(:cat).permit(:name, :age, :gender, :breed, :personality, :helth, :status, :image)
  end
end
