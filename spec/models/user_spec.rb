require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    context "有効な場合" do
      it "名前、メールアドレス、パスワードが揃っている場合有効になること" do
        user = build(:user)
        expect(user).to be_valid
      end
    end

    context "無効な場合" do
      it "ニックネームが空欄の場合無効になること" do
        user = build(:user, nickname: nil)
        user.valid?
        expect(user.errors[:nickname]).to include("を入力してください")
      end

      it "メールアドレスが空欄の場合無効になること" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      it "パスワードが6文字未満の場合無効になること" do
        user = build(:user, password: "a" * 5)
        user.valid?
        expect(user.errors[:password]).to include("は６文字以上で入力してください")
      end

      it "自己紹介が300文字以上の場合無効になること" do
        user = build(:user, introduction: "a" * 301)
        user.valid?
        expect(user.errors[:introduction]).to include("は300文字以内で入力してください")
      end
    end
  end

  describe "関連付け" do
    it "複数の猫を登録できること" do
      association = User.reflect_on_association(:cats)
      expect(association.macro).to eq :has_many
    end

    it "ユーザー削除時、関連する猫も削除されること" do
      user = create(:user)
      create_list(:cat, 3, user: user)
      expect { user.destroy }.to change { Cat.count }.by(-3)
    end
  end
end
