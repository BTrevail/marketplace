Rails.application.routes.draw do
  resources :products
  resources :cart_items
  
  root 'pages#home'
  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'buy', to: 'users#buy'
  get 'buy_item', to: 'cart_items#buy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
