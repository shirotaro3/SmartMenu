require 'rails_helper'

RSpec.describe Category,"モデルに関するテスト", type: :model do
  describe "アソシエーション" do
    it "Shopモデルに属している" do
      is_expected.to belong_to(:shop)
    end
  end

  describe "実際に保存してみる" do
    before do
      @shop = create(:shop)
    end
    context "保存できる場合" do
      it "shop_idを入れて保存" do
        expect(create(:category, shop_id: @shop.id)).to be_valid
      end
    end
    context "保存できない場合" do
      it "shop_idを保存していない" do
        expect(build(:category)).to_not be_valid
      end

      it "nameが空欄" do
        category = build(:category, :no_name)
        category.shop = @shop
        expect(category).to_not be_valid
      end

      it "nameが11文字以上" do
        category = build(:category, :too_long_name)
        category.shop = @shop
        expect(category).to_not be_valid
      end
    end
  end
end
