require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  def login_as(user)
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: "password"
    click_button "ログイン"
    expect(page).to have_content("ログインしました。")
  end

  describe "ユーザー詳細（show）" do
    it "未ログインでも閲覧できること" do
      visit user_path(user)
      expect(page).to have_content(user.nickname)
    end
  end

  describe "プロフィール編集（edit_profile）" do
    context "未ログイン" do
      it "ログインページへリダイレクトされること" do
        visit edit_profile_user_path(user)
        expect(page).to have_current_path(new_user_session_path)
      end
    end

    context "ログイン済み" do
      before do
        login_as(user)
      end

      it "自分のプロフィール編集ページを開けること" do
        visit edit_profile_user_path(user)
        expect(page).to have_content("プロフィール編集")
      end

      it "他人のページはアクセス拒否されること" do
        visit edit_profile_user_path(other_user)
        expect(page).to have_current_path(root_path)
        expect(page).to have_content("権限がありません")
      end

      it "プロフィールを更新できること" do
        visit edit_profile_user_path(user)

        fill_in "ニックネーム", with: "変更後ユーザー"
        fill_in "自己紹介", with: "新しい紹介文"
        click_button "更新する"

        expect(page).to have_current_path(user_path(user))
        expect(page).to have_content("プロフィールを更新しました")
        expect(page).to have_content("変更後ユーザー")
      end

      it "更新失敗時にエラーを表示すること" do
        visit edit_profile_user_path(user)

        fill_in "ニックネーム", with: ""
        click_button "更新する"

        expect(page).to have_content("更新に失敗しました")
        expect(page).to have_content("ニックネームを入力してください")
      end
    end
  end
end
