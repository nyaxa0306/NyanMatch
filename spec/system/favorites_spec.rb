require "rails_helper"

RSpec.describe "Favorites", type: :system do
  let!(:user) { create(:user) }
  let!(:cat)  { create(:cat) }

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

  describe "お気に入り登録" do
    before do
      login(user)
    end

    it "猫をお気に入り登録できること" do
      visit cat_path(cat)

      click_button "☆ お気に入り"

      expect(page).to have_button("★ お気に入り解除")
      expect(user.favorite_cats).to include(cat)
    end

    it "お気に入り済みなら解除できること" do
      user.favorites.create(cat: cat)

      visit cat_path(cat)

      click_button "★ お気に入り解除"

      expect(page).to have_button("☆ お気に入り")
      expect(user.favorite_cats).not_to include(cat)
    end
  end

  describe "お気に入り一覧" do
    before do
      login(user)
      user.favorites.create(cat: cat)
    end

    it "お気に入り一覧に猫が表示されること" do
      visit favorite_cats_path
      expect(page).to have_content(cat.name)
    end
  end
end
