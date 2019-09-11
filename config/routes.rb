Rails.application.routes.draw do
  namespace :user do
    get 'dizzies/create'
    get 'dizzies/destroy'
  end
  namespace :user do
    get 'grins/create'
    get 'grins/destroy'
  end
  namespace :user do
    get 'happies/create'
    get 'happies/destroy'
  end
  root 'pages#top'
  get 'about' => 'pages#about'
  devise_for :shops, controllers: {
    sessions:      'shops/sessions',
    passwords:     'shops/passwords',
    registrations: 'shops/registrations'
  }

  # ユーザー
  namespace :user do
    resources :menus, only:[:show] do
      resources :item_groups, only:[:show]
      resources :emotions, only:[:create,:destroy]
      resources :requests, only:[:create,:new] do
        get :thanks, on: :collection
      end
    end
  end

  # ショップ
  namespace :shop do
    resources :mypages,only:[:show,:edit,:update] do
      collection do
        get :top
        get :cancel
      end
    end
    resources :categories,except:[:show,:new]
    resources :emotions, only:[:index, :destroy]
    resources :requests, only:[:index, :show, :destroy]
    resources :menus, except: :new, shallow: true do
      get :qrcode, on: :member
      resources :special_features, only:[:create, :destroy, :edit]
      resources :item_groups,only:[:create,:destroy], shallow: true do
        member do
          get :move_higher
          get :move_lower
        end
        resources :menu_items, except: :new do
          member do
            get :move_higher
            get :move_lower
          end
        end
      end
    end
  end

  # 管理者
  namespace :admin do
    resources :shops,except: :new
    resources :requests,except: :new
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
