Rails.application.routes.draw do
  root 'pages#top'
  get 'about' => 'pages#about'
  devise_for :shops, controllers: {
    sessions:      'shops/sessions',
    passwords:     'shops/passwords',
    registrations: 'shops/registrations'
  }
  namespace :user do
    resources :menus
    resources :emotions, only:[:create,:destroy]
    resources :requests, only:[:create,:new]
  end
  namespace :shop do
    resources :categories
    resources :mypages
    resources :menus
    get 'menu/:id/qrcode' => 'menus#qrcode',as: 'menu_qrcode'
    resources :shop_images, only:[:create, :destroy]
    resources :special_features, only:[:new, :create, :destroy, :edit]
    resources :emotions, only:[:index, :destroy]
    resources :requests, only:[:index, :show, :destroy]
  end
  namespace :admin do
    resources :manage_shops
    resources :manage_requests
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
