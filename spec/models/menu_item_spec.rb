require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  describe "アソシエーション" do
    it "ItemGroupモデルに属している" do
      is_expected.to belong_to(:item_group)
    end
  end
  
  describe "実際に保存してみる" do
    before do
      shop = create(:shop)
      menu = create(:menu,shop: shop)
      category = create(:category,shop: shop)
      @item_group = build(:item_group, category: category, menu: menu)
    end
    context "保存できる場合" do
      it "ItemGroup_idを入れて保存" do
        expect(create(:menu_item,item_group: @item_group)).to be_valid
      end
    end
    context "保存できない場合" do
      it "Item_group_idが空欄" do
        expect(build(:menu_item)).to_not be_valid
      end
      it "item_nameが空欄" do
        menu_item = build(:menu_item,:no_name)
        menu_item.item_group = @item_group
        expect(menu_item).to_not be_valid
      end
      it "item_nameが11文字以上" do
        menu_item = build(:menu_item,:too_long_name)
        menu_item.item_group = @item_group
        expect(menu_item).to_not be_valid
      end
    end
  end
end
