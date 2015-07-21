Rails.application.routes.draw do
  root "venues#index"
  get '/about' => 'static_pages#about'
  get '/contact' => 'static_pages#contact'
  namespace :admin do
    resources :users, :venues
    get '/dashboard' => 'dashboard#index'
  end
  resources :venues, only: [:show, :index, :create, :new] do
    resources :reviews, only: [:new, :create]
  end
  resources :categories, only: [:show]
  devise_for :users, controllers: { registrations: :registrations }
  resources :users, only: :show
end
