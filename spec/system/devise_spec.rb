require 'rails_helper'

RSpec.describe "Devise", type: :system do
  describe "ユーザー新規登録" do
    it "正常に新規登録できること" do
      visit new_user_registration_path

      fill_in "ニックネーム", with: "新規ユーザー"
      fill_in "メールアドレス", with: "new@example.com"
      fill_in "パスワード（６文字以上）", with: "password"
      fill_in "パスワード（確認用）", with: "password"

      click_button "新規登録"

      expect(page).to have_content("登録が完了しました。ようこそ！")
    end

    it "エラーがあると登録に失敗すること" do
      visit new_user_registration_path

      expect {
        fill_in "ニックネーム", with: ""
        fill_in "メールアドレス", with: ""
        fill_in "パスワード（６文字以上）", with: ""
        fill_in "パスワード（確認用）", with: ""

        click_button "新規登録"
      }.not_to change(User, :count)
    end
  end

  describe "ログイン / ログアウト" do
    let!(:user) { create(:user) }

    it "正常にログインできる" do
      visit new_user_session_path

      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: "password"
      click_button "ログイン"

      expect(page).to have_content("ログインしました。")
    end

    it "ログアウトできる" do
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: "password"
      click_button "ログイン"

      find("button.navbar-toggler").click
      expect(page).to have_selector("#userMenu", visible: true)
      find("#userMenu").click
      click_link "ログアウト"

      expect(page).to have_content("ログアウトしました。")
    end
  end
end
