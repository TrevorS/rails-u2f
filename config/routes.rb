Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :users, only: :none do
    resources :pets, shallow: true
  end

  root to: 'pets#index'
end
