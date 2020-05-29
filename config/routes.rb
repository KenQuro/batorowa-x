Rails.application.routes.draw do
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :boards
  resources :comments, only: %i[create destroy]
  resources :users
  resources :messages, only: %i[create]
  resources :rooms, only: %i[create show index]
end
