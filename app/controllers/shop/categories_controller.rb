class Shop::CategoriesController < ApplicationController
    before_action :authenticate_shop!

    def index
        @category = Category.new
        @categories = current_shop.categories
    end

    def create
        @category = Category.new(category_params)
        @category.shop_id = current_shop.id
        if @category.save
            redirect_to shop_categories_path, :notice =>'カテゴリを登録しました。'
        else
            flash.now[:alert] = '登録に失敗しました。'
            @categories = current_shop.categories
            render :index
        end
    end

    def destroy
        category = Category.find(params[:id])
        correct_shop(category) and return
        if category.destroy
            redirect_to shop_categories_path, :notice=>'カテゴリを削除しました。'
        else
            redirect_to shop_categories_path, :alert=>'アイテムグループに設定されているカテゴリは削除できません。'
        end
    end

    def edit
        @category = Category.find(params[:id])
        correct_shop(@category) and return
    end

    def update
        @category = Category.find(params[:id])
        correct_shop(@category) and return
        if @category.update(category_params)
            redirect_to shop_categories_path, :notice =>'カテゴリ名を変更しました。'
        else
            flash.now[:alert] = '更新に失敗しました。'
            @categories = current_shop.categories
            render :edit
        end
    end
    
    private
    def category_params
        params.require(:category).permit(:name)
    end
end
