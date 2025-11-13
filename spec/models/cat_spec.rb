require 'rails_helper'

RSpec.describe Cat, type: :model do
  let(:user) { create(:user) }
  let(:cat) { build(:cat, user: user) }

  describe "バリデーション" do
    context "有効な場合" do
      it "名前、年齢、性別、地域が揃っている場合有効になること" do
        expect(cat).to be_valid
      end
    end

    context "無効な場合" do
      it "名前が空欄の場合無効になること" do
        cat.name = nil
        expect(cat).not_to be_valid
        expect(cat.errors[:name]).to include("を入力してください")
      end

      it "名前が21文字以上の場合無効になること" do
        cat.name = "a" * 21
        expect(cat).not_to be_valid
        expect(cat.errors[:name]).to include("は20文字以内で入力してください")
      end

      it "年齢が空欄の場合無効になること" do
        cat.age = nil
        expect(cat).not_to be_valid
        expect(cat.errors[:age]).to include("を入力してください")
      end

      it "地域が空欄の場合無効になること" do
        cat.prefecture_id = nil
        expect(cat).not_to be_valid
        expect(cat.errors[:prefecture_id]).to include("を入力してください")
      end

      it "性別が空欄の場合無効になること" do
        cat.gender = nil
        expect(cat).not_to be_valid
        expect(cat.errors[:gender]).to include("を入力してください")
      end

      it "種類が50文字以上の場合無効になること" do
        cat.breed = "a" * 51
        expect(cat).not_to be_valid
        expect(cat.errors[:breed]).to include("は50文字以内で入力してください")
      end

      it "性格が100文字以上の場合無効になること" do
        cat.personality = "a" * 101
        expect(cat).not_to be_valid
        expect(cat.errors[:personality]).to include("は100文字以内で入力してください")
      end

      it "健康状態が100文字以上の場合無効になること" do
        cat.helth = "a" * 101
        expect(cat).not_to be_valid
        expect(cat.errors[:helth]).to include("は100文字以内で入力してください")
      end
    end
  end

  describe "募集ステータスのデフォルト値" do
    it "新規登録時に「募集中」になること" do
      new_cat = Cat.create(name: "テストちゃん", age: 5, gender: "female", user: user)
      expect(new_cat.status).to eq("募集中")
    end
  end

  describe "画像添付" do
    it "画像が添付できること" do
      cat.image.attach(io: File.open(Rails.root.join("spec/fixtures/files/sample.png")),
      filename: "sample.png", content_type: "image/png")
      expect(cat.image).to be_attached
    end
  end

  describe "#display_image" do
    context "画像が添付されている場合" do
      before do
        cat.image.attach(io: File.open(Rails.root.join("spec/fixtures/files/sample.png")),
        filename: "sample.png", content_type: "image/png")
      end

      it "ActiveStorageのVariant系が返ること" do
        result = cat.display_image
        expect(result).to be_a(ActiveStorage::VariantWithRecord)
      end
    end

    context "画像が未添付の場合" do
      it "デフォルト画像が設定されること" do
        result = cat.display_image
        expect(result).to eq(ActionController::Base.helpers.asset_path("default_cat.jpg"))
      end
    end
  end

  describe "#display_age" do
    it "年齢を「X歳」と返すこと" do
      cat.age = 1
      expect(cat.display_age).to eq("1歳")
    end
  end

  describe "関連付け" do
    it "userに属していること" do
      expect(Cat.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end
end
