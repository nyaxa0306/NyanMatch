class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :cat

  validates :user_id, uniqueness: { scope: :cat_id } #同じ猫を二度お気に入りできない
end
