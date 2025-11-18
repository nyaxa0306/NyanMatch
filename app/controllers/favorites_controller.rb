class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cat, only:[:create, :destroy]

  def index
    @favorite_cats = current_user.favorites.includes(:cat).map(&:cat)
  end

  def create
    @cat.favorites.create(user: current_user)
    redirect_to @cat
  end

  def destroy
    favorite = @cat.favorites.find_by(user: current_user)
    favorite.destroy if favorite
    redirect_to @cat
  end

  private

  def set_cat
    @cat = Cat.find(params[:cat_id])
  end
end
