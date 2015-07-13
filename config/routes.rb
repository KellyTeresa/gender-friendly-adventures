Rails.application.routes.draw do
  root 'homes#index'

  resources :businesses, only: [:index, :show]

  devise_for :users, controllers: { registrations: :registrations }
  resources :users, only: :show
end
