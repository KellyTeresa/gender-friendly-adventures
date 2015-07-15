Rails.application.routes.draw do
  root 'businesses#index'
  get '/about' => 'static_pages#about'
  get '/contact' => 'static_pages#contact'
  resources :homes, only: :about
  resources :businesses, only: [:index, :show, :new, :create]
  devise_for :users, controllers: { registrations: :registrations }
  resources :users, only: :show
end
