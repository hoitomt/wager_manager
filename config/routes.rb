Rails.application.routes.draw do
  resources :clients
  resources :tickets, only: [:index]
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'
end
