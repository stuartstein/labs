Bog::Application.routes.draw do
  
  root to: 'creatures#index'

  get '/creatures', to: 'creatures#index'
  
  get '/creatures/new', to: 'creatures#new'

  get '/creatures/:id', to: 'creatures#show'

  get '/creatures/:id/edit', to: 'creatures#edit'

  post '/creatures', to: 'creatures#create'

  put '/creatures/:id', to: 'creatures#update'

  post '/creatures/:id/destroy', to: 'creatures#destroy'
  #http://mythmasters.webs.com/photos/The%20Loch%20Ness%20Monster/loch%20ness%20monster4.gif

end
