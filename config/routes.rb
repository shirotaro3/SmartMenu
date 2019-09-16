Rails.application.routes.draw do

  root 'pages#top'
  get 'about' => 'pages#about'
  devise_for :shops, controllers: {
    sessions:      'shops/sessions',
    passwords:     'shops/passwords',
    registrations: 'shops/registrations'
  }

  # ユーザー
  namespace :user do
    # メニュー
    resources :menus, only:[:show] do
      resources :item_groups, only:[:show]
      resource :grin, only:[:create]
      resource :dizzy, only:[:create]
      resource :happy, only:[:create]
      # リクエスト
      resources :requests, only:[:create,:new] do
        get :thanks, on: :collection
      end
    end
  end

  # ショップ
  namespace :shop do
    resources :requests, only:[:index, :show, :destroy]
    resources :categories,except:[:show,:new]
    # マイページ
    resource :mypages,except:[:new,:create] do
      get :top, on: :collection
      get :cancel, on: :collection
      get :password, on: :collection
      patch :update_password, on: :collection
    end
    # エモーション
    resources :emotions, only:[:index] do
      get :reset, on: :collection
    end
    # メニュー(shallow true)
    resources :menus, except: :new, shallow: true do
      get :qrcode, on: :member
      # アイテムグループ(shallow true)
      resources :item_groups,only:[:create,:destroy,:edit,:update], shallow: true do
        get :move_higher, on: :member
        get :move_lower, on: :member
        # メニューアイテム
        resources :menu_items, except: :new do
          get :move_higher, on: :member
          get :move_lower, on: :member
        end
      end
    end
  end

  # 管理者
  namespace :admin do
    resource :session, only:[:new, :create, :destroy]
    resources :shops, except:[:create,:new]
    resources :deleted_shops, only:[:index,:show]
    resource :tax, only:[:show,:edit,:update]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
