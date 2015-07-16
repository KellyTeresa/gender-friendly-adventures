Rails.application.routes.draw do
  root 'businesses#index'
  get '/about' => 'static_pages#about'
  get '/contact' => 'static_pages#contact'
  resources :businesses do
    resources :reviews
  end
  devise_for :users, controllers: { registrations: :registrations }
  resources :users, only: :show
end
