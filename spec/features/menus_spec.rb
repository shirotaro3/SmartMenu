require 'rails_helper'

RSpec.feature "Shop/Menuに関するテスト", type: :feature do
  before do
    @shop1 = create(:shop, :create_with_menus)
    @shop2 = create(:shop, :create_with_menus)
  end
  feature "ログインしていない状態で" do
    feature "以下のページへアクセスした際のリダイレクト先の確認" do
      scenario "menuの一覧ページ" do
        visit shop_menus_path
        expect(page).to have_current_path new_shop_session_path
      end

      scenario "menuの詳細ページ" do
        visit shop_menu_path(@shop1.menus.first)
        expect(page).to have_current_path new_shop_session_path
      end

      scenario "menuの編集ページ" do
        visit edit_shop_menu_path(@shop1.menus.first)
        expect(page).to have_current_path new_shop_session_path
      end
    end
  end

  feature "ログインした状態で" do
    before do
      login(@shop1)
    end

    feature "以下のページへアクセスした際のリダイレクト先の確認" do
      scenario "他人のmenuの詳細ページ" do
        visit shop_menu_path(@shop2.menus.first)
        expect(page).to have_current_path top_shop_mypages_path
      end

      scenario "他人のmenuの編集ページ" do
        visit edit_shop_menu_path(@shop2.menus.first)
        expect(page).to have_current_path top_shop_mypages_path
      end
    end

    feature "表示内容とリンクの確認" do
      scenario "menuの一覧ページの表示内容とリンクは正しいか" do
        visit shop_menus_path
        menus = @shop1.menus
        menus.each do |menu|
          expect(page).to have_content menu.menu_name
          expect(page).to have_link "詳細",href: shop_menu_path(menu)
        end
        expect(all("a[data-method='delete']")[-1][:href]).to eq(shop_menu_path(@shop1.menus.last))
      end

      scenario "自分のmenuの詳細ページでの表示内容とリンクは正しいか" do
        menu = @shop1.menus.first
        
        visit shop_menu_path(menu)
        expect(page).to have_content menu.menu_name
        expect(page).to have_content menu.color
        # アイテムグループの削除ボタンはあるか
        expect(all("a[data-method='delete']")[-1][:href]).to eq(shop_item_group_path(menu.item_groups.last))
        menu.item_groups.each do |item_group|
          expect(page).to have_link "詳細",href: shop_item_group_menu_items_path(item_group)
          expect(page).to have_content item_group.category.name
        end
      end
    end
    
    feature "メニュー一覧からメニューを作成" do
      before do
        visit shop_menus_path
        find_field('menu[menu_name]').set("name_a")
      end
      scenario "正しく保存できているか" do
        expect {
          find("input[name='commit']").click
        }.to change(@shop1.menus, :count).by(1)
      end
      scenario "リダイレクト先は正しいか" do
        find("input[name='commit']").click
        expect(page).to have_current_path shop_menu_path(Menu.last)
        expect(page).to have_content "name_a"
      end
      scenario "サクセスメッセージが表示されるか" do
        find("input[name='commit']").click
        expect(page).to have_content "作成しました"
      end
    end

    feature "有効ではない内容のmenuをPOST" do
      before do
        visit shop_menus_path
        find_field('menu[menu_name]').set("")
      end
      scenario "保存されないか" do
        expect {
          find("input[name='commit']").click
        }.to change(@shop1.menus, :count).by(0)
      end
      scenario "リダイレクト先は正しいか" do
        find("input[name='commit']").click
        expect(page).to have_current_path shop_menus_path
      end
      scenario "エラーメッセージが表示されるか" do
        find("input[name='commit']").click
        expect(page).to have_content "失敗しました"
      end
    end

    feature "自分が登録したmenuの更新" do
      before do
        menu = @shop1.menus.first
        visit edit_shop_menu_path(menu)
        find_field('menu[menu_name]').set('update_a')
        find("input[name='commit']").click
      end
      scenario "menuが更新されているか" do
        expect(page).to have_content "update_a"
      end
      scenario "リダイレクト先は正しいか" do
        expect(page).to have_current_path shop_menu_path(@shop1.menus.first)
      end
      scenario "サクセスメッセージが表示されるか" do
        expect(page).to have_content "変更を保存しました"
      end
    end

    feature "menuの削除" do
      before do
        menu = @shop1.menus.first
        visit shop_menus_path
      end
      scenario "menuが削除されているか" do
        expect {
          all("a[data-method='delete']").select{|n| n[:href] == shop_menu_path(@shop1.menus.first)}[0].click
        }.to change(@shop1.menus, :count).by(-1)
      end
      scenario "リダイレクト先が正しいか" do
        all("a[data-method='delete']").select{|n| n[:href] == shop_menu_path(@shop1.menus.first)}[0].click
        expect(page).to have_current_path shop_menus_path
      end
      scenario "サクセスメッセージは表示されているか" do
        all("a[data-method='delete']").select{|n| n[:href] == shop_menu_path(@shop1.menus.first)}[0].click
        expect(page).to have_content "メニューを削除しました"
      end
    end

  end
end
