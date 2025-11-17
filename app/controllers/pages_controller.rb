class PagesController < ApplicationController
  def home
    @recent_cats = Cat.order(created_at: :desc).limit(6)
  end
end
