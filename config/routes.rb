Rails.application.routes.draw do
  root "venues#index"
  get "/about" => "static_pages#about"
  get "/coming_soon" => "static_pages#coming_soon"
  # get "/contact" => "static_pages#contact"
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :venues, only: [:index, :show, :edit]
    get "/dashboard" => "dashboard#index"
  end
  resources :venues do
    resources :reviews, only: [:new, :create]
  end
  resources :categories, only: [:show]
  devise_for :users, controllers: { registrations: :registrations }
  resources :users, only: :show
end
