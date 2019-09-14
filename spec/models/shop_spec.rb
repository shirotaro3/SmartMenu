require 'rails_helper'

RSpec.describe Shop, type: :model do
  before do
    @shop = create(:shop)
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
      @shop.state = ''
      expect(@shop.valid?).to eq(false)
    end

    it 'cityが空だとNG' do
      @shop.city = ''
      expect(@shop.valid?).to eq(false)
    end

    it 'streetが空だとNG' do
      @shop.street = ''
      expect(@shop.valid?).to eq(false)
    end

    it 'postal_codeが空だとNG' do
      @shop.postal_code = ''
      expect(@shop.valid?).to eq(false)
    end

    it 'phone_numberが空だとNG' do
      @shop.phone_number = ''
      expect(@shop.valid?).to eq(false)
    end

    it 'emailが空だとNG' do
      @shop.email = ''
      expect(@shop.valid?).to eq(false)
    end
  end
end
