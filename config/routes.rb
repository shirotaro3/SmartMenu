Rails.application.routes.draw do
  root 'pages#top'
  get 'about' => 'pages#about'
  devise_for :shops, controllers: {
    sessions:      'shops/sessions',
    passwords:     'shops/passwords',
    registrations: 'shops/registrations'
  }
  scope :user do
    resources :menus
    resources :reviews, only:[:create,:destroy]
    resources :requests, only:[:create,:new]
  end
  namespace :shop do
    resources :mypages
    resources :menus
    resources :shop_images, only:[:create, :destroy]
    resources :special_features, only:[:new, :create, :destroy, :edit]
    resources :view_reviews, only:[:index, :destroy]
    resources :view_requests, only:[:index, :show, :destroy]
  end
  namespace :admin do
    resources :manage_shops
    resources :manage_reviews
    resources :manage_requests
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
