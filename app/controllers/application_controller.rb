class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    # devise サインアップ後リダイレクト先
    def after_sign_up_path_for(resource)
        top_shop_mypages_path
    end

    # devise サインアウト後リダイレクト先
    def after_sign_out_path_for(resource)
        root_path
    end

    # devise サインイン後リダイレクト先
    def after_sign_in_path_for(resource)
        top_shop_mypages_path
    end

    # targetのshop_idとcurrent_shopが一致しているかチェック
    # redirect_toの戻り値はtrueなので、呼び出し先で and return が使える
    def correct_shop(target)
        if target.shop_id != current_shop.id
            return redirect_to top_shop_mypages_path, :alert => 'アクセスできませんでした。'
        end
    end

    # emotionsのカウントをハッシュで返す
    def set_emotions(shop)
        grin_count = shop.grins.count
        happy_count = shop.happies.count
        dizzy_count = shop.dizzies.count
        return @emotions = {grin: grin_count,happy: happy_count,dizzy: dizzy_count}
    end

    protected
    # devise ストロングパラメータ
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up,keys: [:shop_name,:postal_code,:state,:city,:street,:phone_number])
        devise_parameter_sanitizer.permit(:account_update,keys: [:shop_name,:postal_code,:state,:city,:street,:phone_number])
    end
end
