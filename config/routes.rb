Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :users, only: :none do
    resources :u2f_registrations,
      only: [:index, :new, :create, :destroy]

    resources :u2f_authentications,
      only: [:new, :create]

    resources :pets, shallow: true
  end

  root to: 'pets#index'
end
