Rails.application.routes.draw do
  resources :pets
  devise_for :users
  root to: 'pets#index'
end
