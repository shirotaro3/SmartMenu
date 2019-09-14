class Admin::TaxesController < ApplicationController
    layout 'layouts/admin'
    before_action :current_admin
    before_action :require_admin_sign_in!
    
    def show
    end
    def edit
        @tax = current_tax
    end
    def update
        if current_tax.update(tax_params)
            redirect_to admin_tax_path,:alert=>"税率を変更しました。"
        else
            flash.now[:alert] = "変更に失敗しました。"
            render :edit
        end
    end

    private
    def tax_params
        params.require(:tax).permit(:rate)
    end
end
