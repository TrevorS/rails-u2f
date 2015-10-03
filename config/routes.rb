Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :pets

  resources :u2f_authentication, only: :create
  resources :u2f_registration, only: [:create, :destroy]

  root to: 'pets#index'
end
