require 'rails_helper'

RSpec.feature "Shop/ItemGroupsに関するテスト", type: :feature do
  before do
    @shop1 = create(:shop, :create_with_menus)
    @shop2 = create(:shop, :create_with_menus)
    @item_group = @shop1.menus.first.item_groups.first
  end
  feature "ログインしていない状態で" do
    feature "以下のページへアクセスした際のリダイレクト先の確認" do
      scenario "item_groupの編集ページ" do
        visit edit_shop_item_group_path(@item_group)
        expect(page).to have_current_path new_shop_session_path
      end
    end
  end
  feature "ログインした状態で" do
    before do
      login(@shop1)
    end
    feature "以下のページへアクセスした際のリダイレクト先の確認" do
      before do
        # 他人のitem_group
        @item_group2 = @shop2.menus.first.item_groups.first
      end
      scenario "他人のitem_groupの編集ページ" do
        visit edit_shop_item_group_path(@item_group2)
        expect(page).to have_current_path top_shop_mypages_path
      end
    end  
    feature "表示内容の確認" do
      scenario "item_group編集ページの表示内容は正しいか" do
        visit edit_shop_item_group_path(@item_group)
        expect(page).to have_content @item_group.category.name
      end
    end
  end
end
