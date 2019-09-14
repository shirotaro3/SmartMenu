class Shop::MypagesController < ApplicationController
    before_action :authenticate_shop!
    before_action :reject_incorrect, only: [:show,:edit]
    def top
        # リクエスト5件まで取得(モデルにてorder)
        @requests = current_shop.requests.limit(5)
        # Shopモデルのインスタンスメソッド・happy・dizzy・grinのカウントをハッシュで返す
        @emotions = current_shop.emotions
    end

    def cancel
    end

    def show
    end

    def edit
        @shop = current_shop
    end

    def destroy
        deleted_shop = DeletedShop.duplicate(current_shop)
        begin
            ActiveRecord::Base.transaction do
                deleted_shop.save!
                current_shop.destroy!
                redirect_to root_path,:notice=>"退会処理が完了しました。"
            end
        rescue
            redirect_to action: :cancel,:notice=>"処理に失敗しました。"
        end
    end

    def update
        @shop = current_shop
        if @shop.update(shop_params)
            redirect_to shop_mypage_path(@shop),:notice=>'変更を保存しました。'
        else
            flash.now[:alert] = "更新に失敗しました。"
            render :edit
        end
    end


    private

    def reject_incorrect
        redirect_to top_shop_mypages_path if params[:id].to_i != current_shop.id
    end

    def shop_params
        params.require(:shop).permit(:state,:city,:street,:phone_number,:shop_name,:postal_code,:email)
    end
end
