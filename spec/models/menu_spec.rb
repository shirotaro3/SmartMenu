require 'rails_helper'

RSpec.describe Menu, "モデルに関するテスト",type: :model do
  before do
    @shop = create(:shop)
  end
  describe 'アソシエーション' do
    it "Shopモデルに属している" do
      is_expected.to belong_to(:shop)
    end
  end

  describe '実際に保存してみる' do
    context "保存できる場合" do
      it "shop_idを入れて保存" do
        expect(create(:menu, shop_id: @shop.id)).to be_valid
      end
    end
    context "保存できない場合" do
      it "shop_idを保存していない" do
        expect(build(:menu)).to_not be_valid
      end
      it "menu_nameが空欄" do
        menu = build(:menu, :no_name)
        menu.shop = @shop
        expect(menu).to_not be_valid
      end
      it "menu_nameが10文字以上" do
        menu = build(:menu, :too_long_name)
        menu.shop = @shop
        expect(menu).to_not be_valid
      end
      it "colorが空欄" do
        menu = build(:menu, :no_color)
        menu.shop = @shop
        expect(menu).to_not be_valid
      end
    end
  end
end