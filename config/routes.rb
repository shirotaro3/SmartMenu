Rails.application.routes.draw do
  root 'pages#top'
  get 'about' => 'pages#about'
  devise_for :shops, controllers: {
    sessions:      'shops/sessions',
    passwords:     'shops/passwords',
    registrations: 'shops/registrations'
  }
  namespace :users do
    resources :menus
    resources :reviews, only:[:create,:destroy]
    resources :requests, only:[:create,:new]
  end
  namespace :shops do
    resources :menus
    resources :shop_images, only:[:create, :destroy]
    resources :special_features, only:[:new, :create, :destroy, :edit]
    resources :reviews, only:[:index, :destroy]
    resources :request, only:[:index, :show, :destroy]
  end
  namespace :admins do
    resources :shops
    resources :reviews
    resources :requests
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
