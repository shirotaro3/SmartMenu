class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def after_sign_up_path_for(resource)
        shop_mypage_path(current_shop)
    end

    def after_sign_out_path_for(resource)
        root_path
    end

    def after_sign_in_path_for(resource)
        shop_mypage_path(current_shop)
    end

    protected
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up,keys: [:shop_name,:postal_code,:state,:city,:street,:phone_number,:first_name,:last_name,:first_kana,:last_kana,:shop_color])
        devise_parameter_sanitizer.permit(:account_update,keys: [:shop_name,:postal_code,:state,:city,:street,:phone_number,:first_name,:last_name,:first_kana,:last_kana,:shop_color])
    end
end
