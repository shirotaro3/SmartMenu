require 'rails_helper'

RSpec.describe ItemGroup, type: :model do
  describe "アソシエーション" do
    it "Menuモデルに属している" do
      is_expected.to belong_to(:menu)
    end

    it "Categoryモデルに属している" do
      is_expected.to belong_to(:category)
    end

    it "MenuItemモデルを多数持っている" do
      is_expected.to have_many(:menu_items)
    end
  end
  
  describe "実際に保存してみる" do
    before do
      shop = create(:shop)
      category = create(:category,shop_id: shop.id)
      menu = create(:menu,shop_id: shop.id)
      @item_group = build(:item_group,category_id: category.id,menu_id: menu.id)
    end
    context "保存できる場合" do
      it "menu_idとcategory_idを入れて保存" do
        expect(@item_group).to be_valid
      end
    end

    context "保存できない場合" do
      it "menu_idを保存していない" do
        @item_group.menu_id = ""
        expect(@item_group).to_not be_valid
      end

      it "category_idを保存していない" do
        @item_group.category_id = ""
        expect(@item_group).to_not be_valid
      end
    end
  end
end
