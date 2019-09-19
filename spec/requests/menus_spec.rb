require 'rails_helper'

RSpec.describe "Menus", type: :request do
  before do
    shop = create(:shop)
    sign_in 
  end
  describe 'menus' do
    describe "GET / shop/index" do
      it "リクエストが成功すること" do
        get shop_menus_url
        expect(response).to have_http_status(200)
      end
    end
  end
end
