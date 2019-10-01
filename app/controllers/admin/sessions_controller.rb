class Admin::SessionsController < ApplicationController

    layout 'admin'

    before_action :current_admin, only:[:destroy]
    before_action :require_admin_sign_in!,only: [:destroy]
    before_action :set_admin, only: [:create]

    def new
    end

    def create
        # パスワード認証
        if @admin.authenticate(params[:password])
            sign_in(@admin)
            # slack通知
            notifier = Slack::Notifier.new(Rails.application.credentials.slack_webhook_url)
            notifier.ping("SmartMenu:管理者ログインがありました。\nIP:#{request.remote_ip}")
            redirect_to admin_shops_path,:alert=>"管理者ログインしました。"
        else
            flash.now[:danger] = "failed: invalid email or password."
            render :new
        end
    end

    def destroy
        sign_out
        redirect_to new_admin_session_path
    end

    private
    
    def set_admin
        @admin = Admin.find_by!(email: params[:email])
    rescue
        # emailが一致しないとき (find_by!の例外発生時)
        flash.now[:danger] = "failed: invalid email or password."
        render :new
    end

    # ログインに使用
    def sign_in(admin)
        # クラスメソッドでランダムな文字列を生成
        remember_token = Admin.new_remember_token
        # 永続(期限付き)クッキーにremember_tokenを保存
        cookies.permanent[:admin_remember_token] = remember_token
        # クラスメソッドでハッシュ化したremember_tokenをadminに保存
        admin.update!(remember_token: Admin.encrypt(remember_token))
        @current_admin = admin
    end

    # ログアウトに使用
    def sign_out
        @current_admin = nil
        # クッキーを削除
        cookies.delete(:admin_remember_token)
    end

end
