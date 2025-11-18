require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "バリデーション" do
    it "メッセージがある場合有効になること" do
      application = build(:application)
      expect(application).to be_valid
    end

    it "メッセージがない場合無効になること" do
      application = build(:application, message: nil)
      expect(application).not_to be_valid
      expect(application.errors[:message]).to include("を入力してください")
    end

    it "メッセージが301文字以上の場合無効になること" do
      application = build(:application, message: "a" * 301)
      expect(application).not_to be_valid
      expect(application.errors[:message]).to include("は300文字以内で入力してください")
    end
  end

  describe "enum" do
    it "statusが定義されること" do
      expect(Application.statuses.keys).to contain_exactly("pending", "approved", "rejected")
    end

    it "pending? approved? rejected? で判定できる" do
      application = build(:application, status: :pending)
      expect(application.pending?).to be true
      expect(application.approved?).to be false
      expect(application.rejected?).to be false
    end

    it "status_i18n が日本語に変換される" do
      application = build(:application, status: :approved)
      expect(application.status_i18n).to eq("承認") # i18n設定依存
    end
  end

  describe "関連付け" do
    it "userに属していること" do
      expect(Application.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "catに属していること" do
      expect(Application.reflect_on_association(:cat).macro).to eq(:belongs_to)
    end
  end
end
