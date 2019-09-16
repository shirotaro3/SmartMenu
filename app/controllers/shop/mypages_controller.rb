class Shop::MypagesController < ApplicationController
    before_action :authenticate_shop!
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
        if current_shop.update(shop_params)
            redirect_to shop_mypages_path,:notice=>'変更を保存しました。'
        else
            flash.now[:alert] = "更新に失敗しました。"
            render :edit
        end
    end

    def password
    end

    def update_password
        if current_shop.update_with_password(shop_params)
            sign_in(current_shop, bypass: true)
            redirect_to shop_mypages_path, :notice=>"パスワードを変更しました。"
        else
            flash.now[:alert] = "変更に失敗しました。"
            render :password
        end
    end



    private


    def shop_params
        params.require(:shop).permit(:state,:city,:street,:phone_number,:shop_name,:postal_code,:email,:password,:password_confirmation,:current_password)
    end
end
