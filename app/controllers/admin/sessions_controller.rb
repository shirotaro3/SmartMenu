class Admin::SessionsController < ApplicationController
    before_action :set_admin, only: [:create]

    def new
    end

    def create
        # before_actionでemailが一致する@adminを渡している
        if @admin.authenticate(session_params[:password])
            sign_in(@admin)
            redirect_to root_path
        else
            flash.now[:alert] = t('.flash.invalid_password')
            render :new
        end
    end

    def destroy
        sign_out
        redirect_to new_admin_session_path
    end

    private
    
    def set_admin
        @admin = Admin.find_by!(email: session_params[:mail])
    rescue
        # emailが一致しないとき (find_by!の例外)
        render action: 'new'
    end

    # ログインに使用
    def sign_in(admin)
        # クラスメソッドでランダムな文字列を生成
        remember_token = Admin.new_remember_token
        # 永続(期限付き)クッキーにremember_tokenを代入
        cookies.permanent[:admin_remember_token] = remember_token
        # クラスメソッドで暗号化したremember_tokenをadminに保存
        admin.update!(remember_token: Admin.encrypt(remember_token))
        @admin = admin
    end

    # ログアウトに使用
    def sign_out
        # クッキーを削除
        cookies.delete(:admin_remember_token)
    end

    # ストロングパラメーター
    def session_params
        params.require(:session).permit(:email, :password)
    end
end
