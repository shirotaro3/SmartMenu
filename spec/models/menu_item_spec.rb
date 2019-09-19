require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  describe "アソシエーション" do
    it "ItemGroupモデルに属している" do
      is_expected.to belong_to(:item_group)
    end
  end
  
  describe "実際に保存してみる" do
    context "保存できる場合" do
      it "ItemGroup_idを入れて保存" do
        item_group = create(:item_group)
        expect(create(:menu_item,item_group_id: item_group.id)).to be_valid
      end
    end
  end
end
