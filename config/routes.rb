Rich::Engine.routes.draw do
  
  resources :files, :controller => "files"
  post '/files/update/:id', to: "files#update"
end
