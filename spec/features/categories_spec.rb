require 'rails_helper'

RSpec.feature "Shop/Categoriesに関するテスト", type: :feature do
  before do
    @shop1 = create(:shop, :create_with_menus)
    @shop2 = create(:shop, :create_with_menus)
    @categories = @shop1.categories
  end
  feature "ログインしていない状態で" do
    feature "以下のページへアクセスした際のリダイレクト先の確認" do
      scenario "categoryの一覧ページ" do
        visit shop_categories_path
        expect(page).to have_current_path new_shop_session_path
      end

      scenario "categoryの編集ページ" do
        visit edit_shop_category_path(@categories.first)
        expect(page).to have_current_path new_shop_session_path
      end
    end
  end
  feature "ログインした状態で" do
    before do
      login(@shop1)
    end
    feature "以下のページにアクセスした際のリダイレクト先の確認" do
      before do
        # 他人のデータをセット
        @categories2 = @shop2.categories
      end
      scenario "他人のcategory編集ページ" do
        visit edit_shop_category_path(@categories.first)
      end
    end

    feature "表示内容とリンクの確認" do
      scenario "自分のcategoryの一覧ページの表示内容とリンクは正しいか" do
        visit shop_categories_path
        @categories.each do |category|
          expect(page).to have_content category.name
          expect(page).to have_link "編集",href: edit_shop_category_path(category)
        end
        expect(all("a[data-method='delete']")[-1][:href]).to eq(shop_category_path(@categories.last))
      end

      scenario "自分のcategoryの一覧ページの表示内容の確認" do
        visit shop_categories_path
        expect(page).to have_content @categories.first.name
      end
    end

    feature "category一覧ページからcategoryを投稿" do
      before do
        visit shop_categories_path
        find_field('category[name]').set("name_a")
      end
      scenario "正しく保存できているか" do
        # categoryの数が+1されるか
        expect {
          find("input[name='commit']").click
        }.to change(@shop1.categories, :count).by(1)
      end
      scenario "リダイレクト先は正しいか" do
        find("input[name='commit']").click
        expect(page).to have_current_path shop_categories_path
      end

      scenario "サクセスメッセージが表示されるか" do
        find("input[name='commit']").click
        expect(page).to have_content "カテゴリを登録しました"
      end
    end

    feature "有効ではない内容のcategoryを投稿" do
      before do
        visit shop_categories_path
        # 何も入力しない
        find_field('category[name]').set("")
      end
      scenario "保存されないか" do
        # categoryの数が変化しないか
        expect{
          find("input[name='commit']").click
        }.to change(@shop1.categories, :count).by(0)
      end

      scenario "リダイレクト先は正しいか" do
        find("input[name='commit']").click
        expect(page).to have_current_path shop_categories_path
      end

      scenario "エラーメッセージが表示されるか" do
        find("input[name='commit']").click
        expect(page).to have_content "失敗しました"
      end
    end

    feature "自分が投稿したcategoryの更新" do
      before do
        category = @categories.first
        visit edit_shop_category_path(category)
        find_field('category[name]').set('update_a')
        find("input[name='commit']").click
      end
      scenario "categoryは更新されているか" do
        expect(page).to have_content "update_a"
      end

      scenario "リダイレクト先は正しいか" do
        expect(page).to have_current_path shop_categories_path
      end

      scenario "サクセスメッセージが表示されるか" do
        expect(page).to have_content "カテゴリ名を変更しました"
      end
    end

    feature "有効ではない内容のcategoryの更新" do
      before do
        @category = @categories.first
        visit edit_shop_category_path(@category)
        find_field('category[name]').set(nil)
        find("input[name='commit']").click
      end

      scenario "エラーメッセージが表示されるか" do
        expect(page).to have_content "失敗しました"
      end
    end

    feature "categoryの削除" do
      before do
        @category = @categories.first
        visit shop_categories_path
      end
      scenario "categoryが削除されているか" do
        # 関連付けがあると削除できないため、item_groupを削除する
        @category.item_groups.destroy_all
        expect {
          all("a[data-method='delete']").select{|n| n[:href] == shop_category_path(@category)}[0].click
        }.to change(@categories, :count).by(-1)
      end
    
      scenario "リダイレクト先は正しいか" do
        # 関連付けがあると削除できないため、item_groupを削除する
        @category.item_groups.destroy_all
        all("a[data-method='delete']").select{|n| n[:href] == shop_category_path(@category)}[0].click
        expect(page).to have_current_path shop_categories_path
      end

      scenario "関連付けがあるとき、削除に失敗するか" do
        expect {
          all("a[data-method='delete']").select{|n| n[:href] == shop_category_path(@category)}[0].click
        }.to change(@categories, :count).by(0)
      end
    end
  end
end
