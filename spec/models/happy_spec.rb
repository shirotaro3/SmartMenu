require 'rails_helper'

RSpec.describe Happy, type: :model do
  describe "アソシエーション" do
    it "Shopモデルに属している" do
      is_expected.to belong_to(:shop)
    end
  end

  describe "実際に保存してみる" do
    context "保存できる場合" do
      it "shop_idを入れて保存" do
        shop = create(:shop)
        expect(create(:happy, shop: shop)).to be_valid
      end
    end
    context "保存できない場合" do
      it "shop_idを保存していない" do
        expect(build(:happy)).to_not be_valid
      end
    end
  end
end
