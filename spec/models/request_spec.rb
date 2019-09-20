require 'rails_helper'

RSpec.describe Request,"モデルに関するテスト", type: :model do
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
        expect(create(:request, shop: @shop)).to be_valid
      end
    end
    context "保存できない場合" do
      it "shop_idを保存していない" do
        expect(build(:request)).to_not be_valid
      end
      it "titleが空欄" do
        request = build(:request,:no_title)
        request.shop = @shop
        expect(request).to_not be_valid
      end
      it "titleが13文字以上" do
        request = build(:request,:too_long_title)
        request.shop = @shop
        expect(request).to_not be_valid
      end
      it "messageが空欄" do
        request = build(:request,:no_message)
        request.shop = @shop
        expect(request).to_not be_valid
      end
      it "messageが201文字以上" do
        request = build(:request,:no_title)
        request.shop = @shop
        expect(request).to_not be_valid
      end
    end
  end
end

