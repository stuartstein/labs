Ritly::Application.routes.draw do

  root to: 'rits#index'
  
  get '/rits', to: 'rits#index'
  
  post '/rits', to: 'rits#create'

  get '/go/:code', to: 'rits#visited'

  get '/preview/:code/', to: 'rits#preview'

  post '/update', to: 'rits#update'

 end
