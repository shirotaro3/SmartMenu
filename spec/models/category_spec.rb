require 'rails_helper'

RSpec.describe Category, type: :model do
  before do
    @shop = create(:shop) do |shop|
      shop.categories.build(FactoryBot.attributes_for(:category))
    end
  end
  describe "バリデーション" do
    it "nameが入力されていればOK" do
      expect(@category.valid?).to eq(true)
    end

    it "nameが入力されていなければNG" do
      @category.name = ""
      expect(@category.valid?).to eq(false)
    end
  end
end
