class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    helper_method :current_tax

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
            redirect_to top_shop_mypages_path, :alert => 'アクセスできませんでした。'
        end
    end

    # adminログイン状態保持(クッキーを確認して@current_adminをセット)
    def current_admin
        # クッキーのremember_tokenをハッシュ化して代入
        remember_token = Admin.encrypt(session[:admin_remember_token])
        # ハッシュ化されたremember_tokenでfind、一致したadminを代入
        @current_admin ||= Admin.find_by(remember_token: remember_token)
    end

    # adminログイン状態を真偽値で返す/require_admin_sign_in!で使用
    def signed_in?
        @current_admin.present?
    end

    # 税率(ヘルパーメソッド)
    def current_tax
        @tax = Tax.first
    end

    private
    # adminサインインしていなければルートへリダイレクト
    def require_admin_sign_in!
        redirect_to root_path unless signed_in?
    end

    protected
    # devise ストロングパラメータ
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up,keys: [:shop_name,:postal_code,:state,:city,:street,:phone_number])
        devise_parameter_sanitizer.permit(:account_update,keys: [:shop_name,:postal_code,:state,:city,:street,:phone_number])
    end
end
