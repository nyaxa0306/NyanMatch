require 'rails_helper'

RSpec.describe "Applications", type: :system do
  let(:protector) { create(:user, role: :protector) }
  let(:user) { create(:user, role: :adopter) }
  let(:cat) { create(:cat, user: protector) }

  def login(user)
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: "password"
    click_button "ログイン"
    expect(page).to have_content("ログインしました。")
  end

  describe "応募(create)" do
    before do
      login(user)
    end

    it "里親希望が応募できること" do
      visit cat_path(cat)

      fill_in "application_message", with: "よろしくお願いします"
      click_button "応募する"

      expect(page).to have_content("応募が完了しました")
    end
  end
  
  describe "応募一覧(index)" do
    let!(:application) { create(:application, user: user, cat: cat, message: "会いたいです") }

    it "保護主は自分の猫への応募一覧を見られること" do
      login(protector)

      visit applications_path

      expect(page).to have_content("会いたいです")
      expect(page).to have_content(protector.nickname)
      expect(page).to have_content(cat.name)
    end

    it "里親希望は自分の応募履歴だけ見られること" do
      login(user)

      visit applications_path

      expect(page).to have_content("会いたいです")
      expect(page).to have_content(cat.name)
      expect(page).to have_content(user.nickname)
    end
  end

  describe "ステータス更新(update_status)" do
    let!(:application) { create(:application, user: user, cat: cat) }

    it "保護主はステータスを更新できること" do
      login(protector)

      visit applications_path
      click_link "承認", href: update_status_application_path(application, status: "approved")

      expect(page).to have_content("ステータスを更新しました")
      expect(application.reload.status).to eq("approved")
    end

    it "里親希望はステータス変更ボタンが見えないこと" do
      login(user)
      visit applications_path

      expect(page).not_to have_button("承認")
      expect(page).not_to have_button("拒否")
    end
  end
end
