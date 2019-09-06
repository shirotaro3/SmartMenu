Rails.application.routes.draw do
  root 'pages#top'
  get 'about' => 'pages#about'
  devise_for :shops, controllers: {
    sessions:      'shops/sessions',
    passwords:     'shops/passwords',
    registrations: 'shops/registrations'
  }
  scope module: :user do
    resources :menus, only:[:show]
    resources :menu_items, only:[:index,:show]
    resources :emotions, only:[:create,:destroy]
    resources :requests, only:[:create,:new]
  end
  namespace :shop do
    get 'mypage/top' => 'mypages#top', as:'mypage_top'
    resources :mypages,only:[:show,:edit,:update]
    resources :categories,except:[:show,:new]
    resources :emotions, only:[:index, :destroy]
    resources :requests, only:[:index, :show, :destroy]
    resources :menus, except: :new, shallow: true do
      get :qrcode, on: :member
      resources :special_features, only:[:create, :destroy, :edit]
    end
    resources :item_groups,only:[:create,:destroy], shallow: true do
      resources :menu_items, except: :new
    end
  end
  namespace :admin do
    resources :shops,except: :new
    resources :requests,except: :new
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
