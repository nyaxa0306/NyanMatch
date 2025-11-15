require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "バリデーション" do
    it "有効なお気に入りは保存できること" do
      favorite = build(:favorite)
      expect(favorite).to be_valid
    end

    it "同じ猫を二度お気に入りできないこと" do
      user = create(:user)
      cat = create(:cat)
      #一回目
      create(:favorite, user: user, cat: cat)
      #二回目
      duplicate_fav = build(:favorite, user: user, cat: cat)
      expect(duplicate_fav).not_to be_valid
    end
  end

  describe "関連付け" do
    it "userに属していること" do
      expect(Favorite.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "catに属していること" do
      expect(Favorite.reflect_on_association(:cat).macro).to eq(:belongs_to)
    end
  end
end
