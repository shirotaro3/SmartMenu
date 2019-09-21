require 'rails_helper'

RSpec.feature "Mypage、サインアップ・ログイン・ログアウトに関するテスト", type: :feature do
  before do
    @shop = create(:shop, :create_with_menus)
  end

  feature "サインアップの確認" do
    before do
      visit new_shop_registration_path
      find_field('shop[shop_name]').set("name_a")
      find_field('shop[email]').set("aa@aa.com")
      select "埼玉県", from: "shop[state]"
      find_field('shop[city]').set("City_a")
      find_field('shop[street]').set("street_b")
      find_field('shop[postal_code]').set("3400011")
      find_field('shop[phone_number]').set("0123444333")
      find_field('shop[password]').set("password")
      find_field('shop[password_confirmation]').set("password")
    end

    scenario "正しくサインアップできているか" do
      expect {
        find("input[name='commit']").click
      }.to change(Shop, :count).by(1)
    end
    scenario "リダイレクト先は正しいか" do
      find("input[name='commit']").click
      expect(page).to have_current_path top_shop_mypages_path
    end
    scenario "サクセスメッセージは正しく表示されるか" do
      find("input[name='commit']").click
      expect(page).to have_content "アカウント登録が完了しました"
    end
  end

  feature "有効でない内容のサインアップの確認" do
    before do
      visit new_shop_registration_path
      find_field('shop[shop_name]').set(nil)
      find_field('shop[email]').set("aa@aa.com")
      find_field('shop[password]').set("password")
      find_field('shop[password_confirmation]').set("password")
      find("input[name='commit']").click
    end
    scenario "リダイレクト先は正しいか" do
      expect(page).to have_current_path new_shop_registration_path
    end
    scenario "エラーメッセージは正しく表示されるか" do
      expect(page).to have_content "入力内容をご確認下さい"
    end
  end

  feature "ログインの確認" do
    before do
      visit new_shop_session_path
      find_field('shop[email]').set(@shop.email)
      find_field('shop[password]').set(@shop.password)
      find("input[name='commit']").click
    end
    scenario "正しくログインして、リダイレクトされているか" do
      expect(page).to have_current_path top_shop_mypages_path
    end
    scenario "サクセスメッセージは正しく表示されているか" do
      expect(page).to have_content "ログインしました"
    end
  end

  feature "有効でない内容でのログインの確認" do
    before do
      visit new_shop_session_path
      find_field('shop[email]').set(nil)
      find_field('shop[password]').set(nil)
      find("input[name='commit']").click
    end
    scenario "リダイレクト先は正しいか" do
      expect(page).to have_current_path new_shop_session_path
    end
  end

  feature "ログアウトの確認" do
    before do
      login(@shop)
      visit top_shop_mypages_path
      all("a[data-method='delete'][href='/sign_out']")[0].click
    end
    scenario "正しくログアウトして、リダイレクトされているか" do
      expect(page).to have_current_path "/"
    end
    scenario "サクセスメッセージは正しく表示されているか" do
      expect(page).to have_content "ログアウトしました"
    end
  end

  feature "ヘッダーのリンクの確認" do
    scenario "ログイン時" do
      login(@shop)
      visit root_path
      expect(page).to have_link "",href: top_shop_mypages_path
    end
    scenario "ログアウト時" do
      visit root_path
      expect(page).to have_link "",href: new_shop_session_path
    end
  end
end