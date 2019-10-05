class Shop::InquiriesController < ApplicationController
    before_action :authenticate_shop!
    
    def new
        @inquiry = Inquiry.new
    end

    def create
        @inquiry = Inquiry.new(inquiry_params)
        # paramsがbackの時、処理を中断
        render :new and return if params[:back]
        if @inquiry.valid?
            @inquiry.insert_shop_info(current_shop)
            InquiryMailer.send_mail(@inquiry).deliver_now
            redirect_to new_shop_inquiry_path,:notice=>"正常に送信されました。"
        else
            flash.now[:alert] = "送信に失敗しました。"
            render :new
        end
    end

    def confirm
        @inquiry = Inquiry.new(inquiry_params)
        if @inquiry.valid?
            render
        else
            flash.now[:alert] = "送信に失敗しました。"
            render :new
        end
    end
    
    private
    def inquiry_params
        params.require(:inquiry).permit(:name,:message)
    end
end
