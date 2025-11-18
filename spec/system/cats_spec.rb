require 'rails_helper'

RSpec.describe "Cats", type: :system do
  let!(:user) { create(:user, role: "protector") }
  let!(:other_user) { create(:user, role: "protector") }
  let!(:cat) { create(:cat, user: user, name: "タマ") }

  before do
    driven_by(:rack_test)
  end

  def login(user)
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: "password"
    click_button "ログイン"
    expect(page).to have_content("ログインしました。")
  end

  describe "猫一覧（index）" do
    it "誰でも閲覧できること" do
      visit cats_path
      expect(page).to have_content("タマ")
    end
  end

  describe "猫詳細（show）" do
    it "誰でも閲覧できること" do
      visit cat_path(cat)
      expect(page).to have_content("タマ")
    end
  end

  describe "猫の新規登録（new/create）" do
    context "未ログイン" do
      it "ログインページへリダイレクトされること" do
        visit new_cat_path
        expect(page).to have_current_path(new_user_session_path)
      end
    end

    context "ログイン済み" do
      before do
        login(user)
      end

      it "正常に登録できること" do
        visit new_cat_path

        fill_in "名前", with: "ミケ"
        fill_in "年齢", with: 3
        choose "gender_male"
        select "東京都", from: "都道府県"

        click_button "登録する"

        expect(page).to have_content("猫ちゃんを登録しました")
        expect(page).to have_content("ミケ")
        expect(page).to have_current_path(cat_path(Cat.last))
      end

      it "エラーがあると登録に失敗すること" do
        visit new_cat_path

        fill_in "名前", with: ""
        click_button "登録する"

        expect(page).to have_content("登録に失敗しました")
        expect(page).to have_current_path(cats_path)
      end
    end
  end

  describe "猫編集（edit/update）" do
    context "未ログイン" do
      it "ログインページへリダイレクトされること" do
        visit edit_cat_path(cat)
        expect(page).to have_current_path(new_user_session_path)
      end
    end

    context "ログイン済み" do
      before do
        login(user)
      end

      it "自分の猫なら編集ページを開けること" do
        visit edit_cat_path(cat)
        expect(page).to have_content("編集")
      end

      it "編集して更新できること" do
        visit edit_cat_path(cat)

        fill_in "名前", with: "変更後タマ"
        click_button "更新する"

        expect(page).to have_content("猫ちゃんの情報を更新しました")
        expect(page).to have_content("変更後タマ")
      end

      it "更新失敗時はエラーを表示すること" do
        visit edit_cat_path(cat)

        fill_in "名前", with: ""
        click_button "更新する"

        expect(page).to have_content("更新に失敗しました")
        expect(page).to have_content("名前を入力してください")
      end

      it "他人の猫は編集できずリダイレクトされること" do
        click_link "ログアウト"
        login(other_user)
        visit edit_cat_path(cat)

        expect(page).to have_current_path(cats_path)
        expect(page).to have_content("権限がありません")
      end
    end
  end

  describe "猫削除（destroy）" do
    context "ログイン済み" do
      before do
        login(user)
      end

      it "自分の猫を削除できること" do
        visit cat_path(cat)
        click_link "削除"

        expect(page).to have_content("猫ちゃんの情報を削除しました")
        expect(page).not_to have_content("タマ")
        expect(page).to have_current_path(cats_path)
      end

      it "他人の猫は削除できないこと" do
        click_link "ログアウト"
        login(other_user)
        visit cat_path(cat)

        visit cat_path(cat) rescue nil
        page.driver.submit :delete, cat_path(cat), {}

        expect(page).to have_current_path(cats_path)
        expect(page).to have_content("権限がありません")
      end
    end
  end

  describe "登録した猫一覧（user_cats）" do
    before do
      login(user)
    end
    it "ユーザーの猫一覧が見られること" do
      visit cats_user_path(user)

      expect(page).to have_content("登録した猫ちゃん一覧")
      expect(page).to have_content("タマ")
    end
  end
end
