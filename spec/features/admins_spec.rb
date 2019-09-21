require 'rails_helper'

RSpec.feature "Adminに関するテスト", type: :feature do
  before do
    @admin = create(:admin)
  end
  feature "ログインの確認" do
    before do
      visit new_admin_session_path
      find_field('email').set(@admin.email)
      find_field('password').set(@admin.password)
      find("input[name='commit']").click
    end
    scenario "正しくログインして、リダイレクトされているか" do
      expect(page).to have_current_path admin_shops_path
    end
  end

  feature "有効でない内容でのログインの確認" do
    before do
      visit new_admin_session_path
      find_field('email').set(@admin.email)
      # 正しくないパスワード
      find_field('password').set("paspas")
      find("input[name='commit']").click
    end
    scenario "エラーメッセージが表示されるか" do
      expect(page).to have_content "failed"
    end
  end
  feature "ログインしていない状態で" do
    before do
      @shop = create(:shop)
      @deleted_shop = create(:deleted_shop)
      current_tax = create(:tax)
    end
    feature "以下のページにアクセスした際のリダイレクト先" do
      scenario "admin/shopの一覧ページ" do
        visit admin_shops_path
        expect(page).to have_current_path root_path
      end
      
      scenario "admin/shopの詳細ページ" do
        visit admin_shop_path(@shop)
        expect(page).to have_current_path root_path
      end

      scenario "admin/shopの編集ページ" do
        visit edit_admin_shop_path(@shop)
        expect(page).to have_current_path root_path
      end

      scenario "admin/deleted_shopの一覧ページ" do
        visit admin_deleted_shops_path
        expect(page).to have_current_path root_path
      end

      scenario "admin/deleted_shopの詳細ページ" do
        visit admin_deleted_shop_path(@deleted_shop)
        expect(page).to have_current_path root_path
      end

      scenario "current_taxの詳細ページ" do
        visit admin_tax_path
        expect(page).to have_current_path root_path
      end

      scenario "current_taxの編集ページ" do
        visit edit_admin_tax_path
        expect(page).to have_current_path root_path
      end
    end
  end
end
