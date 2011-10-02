Dummy::Application.routes.draw do
  resources :posts

  Rails.application.routes.draw do

  resources :posts

    mount Rich::Engine => "/rich"
    
    resources :test
    root :to => 'posts#index'
  end

end
