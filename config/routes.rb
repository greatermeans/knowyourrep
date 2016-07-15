Rails.application.routes.draw do
  resources :messages
  resources :politicians 
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/sessions' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  root to: 'sessions#new'
  get '/register' => 'users#new', as: '/register'
end
