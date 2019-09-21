require 'rails_helper'

RSpec.feature "Shop/MenuItemsに関するテスト", type: :feature do
  before do
    @shop1 = create(:shop, :create_with_menus)
    @shop2 = create(:shop, :create_with_menus)
    menu = @shop1.menus.first
    @item_group = menu.item_groups.first
    current_tax = create(:tax)
  end
  feature "ログインしていない状態で" do
    feature "以下のページへアクセスした際のリダイレクト先の確認" do
      scenario "menu_itemの一覧ページ" do
        visit shop_item_group_menu_items_path(@item_group)
        expect(page).to have_current_path new_shop_session_path
      end

      scenario "menu_itemの編集ページ" do
        visit edit_shop_menu_item_path(@item_group.menu_items.first)
        expect(page).to have_current_path new_shop_session_path
      end
    end
    
    feature "ログインした状態で" do
      before do
        login(@shop1)
      end
      feature "以下のページへアクセスした際のリダイレクト先の確認" do
        before do
          # 他人(shop2)のデータをセット
          @menu2 = @shop2.menus.first
          @item_group2 = @menu2.item_groups.first
        end
        scenario "他人のmenu_itemの一覧ページ" do
          # 他人のmenu_item一覧ページにアクセス
          visit shop_item_group_menu_items_path(@item_group2)
          expect(page).to have_current_path top_shop_mypages_path
        end

        scenario "他人のmenu_itemの編集ページ" do
          #　他人のmenu_item編集ページにアクセス
          visit edit_shop_menu_item_path(@item_group2.menu_items.first)
          expect(page).to have_current_path top_shop_mypages_path
        end
      end

      feature "表示内容とリンクの確認" do
        scenario "menu_itemの一覧ページの表示内容とリンクは正しいか" do
          visit shop_item_group_menu_items_path(@item_group)
          menu_items = @item_group.menu_items
          menu_items.each do |menu_item|
            expect(page).to have_content menu_item.item_name
            expect(page).to have_link "編集",href: edit_shop_menu_item_path(menu_item)
          end
          expect(page).to have_link "",href: edit_shop_item_group_path(@item_group)
          expect(page).to have_content @item_group.category.name
        end

        scenario "menu_itemの編集ページの表示内容は正しいか" do
          menu_item = @item_group.menu_items.first
          visit edit_shop_menu_item_path(menu_item)
          expect(page).to have_content menu_item.item_name
        end
      end

      feature "menu_item一覧ページからmenu_itemを投稿" do
        before do
          visit shop_item_group_menu_items_path(@item_group)
          find_field('menu_item[item_name]').set("name_a")
          find_field('menu_item[price]').set(900)
        end
        scenario "正しく保存できているか" do
          expect {
            find("input[name='commit']").click
          }.to change(@item_group.menu_items,:count).by(1)
        end

        scenario "サクセスメッセージは表示されるか" do
          find("input[name='commit']").click
          expect(page).to have_content "追加しました"
        end
      end

      feature "有効でない内容のmenu_itemを投稿" do
        before do
          visit shop_item_group_menu_items_path(@item_group)
          find_field('menu_item[item_name]').set("")
          find_field('menu_item[price]').set(900)
        end
        scenario "保存されないか" do
          expect{
            find("input[name='commit']").click
          }.to change(@item_groups.menu_items, :count1).by(0)
        end

        scenario "リダイレクト先は正しいか" do
          find("input[name='commit']").click
          expect(page).to have_current_path shop_item_group_menu_items_path(@item_group)
        end

        scenario "エラーメッセージが表示されるか" do
          find("input[name='commit']").click
          expect(page).to have_content "失敗しました"
        end
      end

      feature "自分が投稿したmenu_itemの更新" do
        before do
          menu_item = @item_group.menu_items.first
          visit edit_shop_menu_item_path(menu_item)
          find_field('menu_item[item_name]').set('update_a')
          find_field('menu_item[price]').set(99912)
          find("input[name='commit']").click
        end
        scenario "menu_itemが更新されているか" do
          expect(page).to have_content "update_a"
          expect(page).to have_content "99912"
        end

        scenario "リダイレクト先は正しいか" do
          expect(page).to have_current_path shop_item_group_menu_items_path(@item_group)
        end

        scenario "サクセスメッセージは表示されるか" do
          expect(page).to have_content "保存しました"
        end
      end

      feature "有効でない内容のmenu_itemの更新" do
        before do
          menu_item = @item_group.menu_items.first
          visit edit_menu_item_path(menu_item)
          find_field("input[name='commit']").click
          find("input[name='commit']").click
        end

        scenario "エラーメッセージが表示されるか" do
          expect(page).to have_content "失敗しました"
        end
      end

      feature "menu_itemの削除" do
        before do
          @menu_item = @item_group.menu_items.first
          visit shop_item_group_menu_items_path(@item_group)
        end
        scenario "menu_itemが削除されているか" do
          expect{
            all("a[data-method='delete']").select{|n| n[:href] == shop_menu_item_path(@menu_item)}[0].click
          }.to change(@item_group.menu_items, :count).by(-1)
        end

        scenario "リダイレクト先は正しいか" do
          all("a[data-method='delete']").select{|n| n[:href] == shop_menu_item_path(@menu_item)}[0].click
          expect(page).to have_current_path shop_item_group_menu_items_path(@item_group)
        end
      end
    end
  end
end
