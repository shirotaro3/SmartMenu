require 'rails_helper'

RSpec.describe Shop, type: :model do
  before do
    @user = create(:shop)
  end

  describe 'バリデーション' do
    it '全部のカラムに値が設定されていればOK'do
      expect(@shop.valid?).to eq(true)
    end

    it 'shop_nameが空だとNG' do
      @shop.shop_name = ''
      expect(@shop.valid?).to eq(false)
    end

    it 'stateが空だとNG' do
      @shop.shop
  end
end
