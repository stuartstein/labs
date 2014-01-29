Store::Application.routes.draw do
  resources :categories, :products

  root to: 'categories#index'
end
