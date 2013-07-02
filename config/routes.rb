Rich::Engine.routes.draw do
  
	resources :files, :controller => "files"
	get '/display/:id', to: 'display#show', as: 'display'
	get '/display/:id/:style', to: 'display#show', as: 'display'
  
end
