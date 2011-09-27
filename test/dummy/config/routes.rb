Rails.application.routes.draw do

  mount Rich::Engine => "/rich"
  
  root :to => 'test#index'
end
