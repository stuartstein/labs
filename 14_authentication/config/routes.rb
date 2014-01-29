Ritly::Application.routes.draw do
  resources :users, :sessions

  get "sessions/new"
  get "sessions/destroy"
  get "/sign_up", to: 'users#new'
  get "/users/:id", to: 'users#show'

  root to: 'rits#index'
  
  get '/rits', to: 'rits#index'
  
  post '/rits', to: 'rits#create'

  get '/go/:code', to: 'rits#visited'

  get '/preview/:code/', to: 'rits#preview'

  post '/update', to: 'rits#update'

 end
