class Shop::CategoriesController < ApplicationController
    def index
        @categories = current_shop.categories
    end
    def create
        @category = Category.new(category_params)
        @category.shop_id = current_shop.id
        if @category.save
            redirect_to shop_categories_path, :notice =>'カテゴリを登録しました。'
        else
            flash.now[:alert] = '入力内容をご確認下さい。'
            @categories = current_shop.categories
            render :index
        end
    end
    def destroy
        category = Category.find(params[:id])
        category.destroy
        redirect_to shop_categories_path, :notice=>'カテゴリと関連アイテムを削除しました。'
    end
    def edit
        @category = Category.find(params[:id])
    end
    def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
            redirect_to shop_categories_path, :notice =>'カテゴリの名称を変更しました。'
        else
            flash.now[:alert] = '入力内容をご確認下さい。'
            @categories = current_shop.categories
            render :edit
        end
    end
    private
    def category_params
        params.require(:category).permit(:name)
    end
end
