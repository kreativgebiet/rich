Rails.application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

    resources :posts

    mount Rich::Engine => "/rich"
    
    resources :test
    root :to => 'posts#index'
end
