class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def after_sign_up_path_for(resource)
        top_shop_mypages_path
    end

    def after_sign_out_path_for(resource)
        root_path
    end

    def after_sign_in_path_for(resource)
        top_shop_mypages_path
    end

    def correct_user
        if current_shop.id != params[:shop_id].to_i
            redirect_to root_path, :alert => 'アクセス権限がありません。'
        end
    end

    protected
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up,keys: [:shop_name,:postal_code,:state,:city,:street,:phone_number])
        devise_parameter_sanitizer.permit(:account_update,keys: [:shop_name,:postal_code,:state,:city,:street,:phone_number,:first_name,:last_name,:first_kana,:last_kana,:shop_color])
    end
end
