Rails.application.routes.draw do
  root 'businesses#index'

  resources :businesses, only: [:index, :show, :new, :create]

  devise_for :users, controllers: { registrations: :registrations }
  resources :users, only: :show
end
