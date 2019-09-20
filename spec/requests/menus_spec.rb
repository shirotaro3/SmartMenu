require 'rails_helper'

RSpec.describe "Menus", type: :request do
  before do
    @shop = create(:shop, :create_with_menus)
    login(@shop)
  end
  describe 'menus' do
    describe "GET / shop/index" do
      it "リクエストが成功すること" do
        get shop_menus_url
        expect(response).to have_http_status(200)
      end
    end
    describe "GET / shop/show" do
      it "リクエストが成功すること" do
        get shop_menu_url(@shop.menus.first)
        expect(response).to have_http_status(200)
      end
    end
    describe "GET / shop/edit" do
      it "リクエストが成功すること" do
        get edit_shop_menu_url(@shop.menus.first)
        expect(response).to have_http_status(200)
      end
    end
  end
end
