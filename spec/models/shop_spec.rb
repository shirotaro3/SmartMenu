require 'rails_helper'

RSpec.describe Shop,"モデルに関するテスト", type: :model do
  describe 'アソシエーション' do
    it "Menuモデルを多数持っている" do
      is_expected.to have_many(:menus)
    end

    it "Categoryモデルを多数持っている" do
      is_expected.to have_many(:categories)
    end

    it "Grinモデルを多数持っている" do
      is_expected.to have_many(:grins)
    end

    it "Dizzyモデルを多数持っている" do
      is_expected.to have_many(:dizzies)
    end

    it "Happyモデルを多数持っている" do
      is_expected.to have_many(:happies)
    end

    it "Requestモデルを多数持っている" do
      is_expected.to have_many(:requests)
    end
  end

  describe "実際に保存してみる" do
    context "保存できる場合" do
      it "全項目を入力" do
        expect(create(:shop)).to be_valid
      end
    end

    describe "保存できない場合" do
      it "shop_nameが空欄" do
        expect(build(:shop, :no_name)).to_not be_valid
      end

      it "shop_nameが11文字以上" do
        expect(build(:shop, :too_long_name)).to_not be_valid
      end

      it "shop_nameが1文字以下" do
        expect(build(:shop, :too_short_name)).to_not be_valid
      end

      it "stateが空欄" do
        expect(build(:shop, :no_state)).to_not be_valid
      end

      it "cityが空欄" do
        expect(build(:shop, :no_city)).to_not be_valid
      end

      it "cityが9文字以上" do
        expect(build(:shop, :too_long_city)).to_not be_valid
      end

      it "streetが空欄" do
        expect(build(:shop, :no_street)).to_not be_valid
      end

      it "streetが41文字以上" do
        expect(build(:shop, :too_long_street)).to_not be_valid
      end

      it "streetが5文字以下" do
        expect(build(:shop, :too_short_street)).to_not be_valid
      end

      it "postal_codeが空欄" do
        expect(build(:shop, :no_postal_code)).to_not be_valid
      end

      it "phone_numberが空欄" do
        expect(build(:shop, :no_phone_number)).to_not be_valid
      end
    end
  end
end
