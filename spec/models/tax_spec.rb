require 'rails_helper'

RSpec.describe Tax,"モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    context "保存できる場合" do
      it "rateを入力して保存" do
        expect(create(:tax)).to be_valid
      end
    end
    context "保存できない場合" do
      it "rateが空欄" do
        expect(build(:tax,:no_rate)).to_not be_valid
      end
    end
  end
end
