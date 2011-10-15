Rails.application.routes.draw do

  mount Rich::Engine => '/rich'

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

    resources :posts
    
    resources :test
    root :to => 'posts#index'
end
