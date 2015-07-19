Rails.application.routes.draw do
  root 'venues#index'
  get '/about' => 'static_pages#about'
  get '/contact' => 'static_pages#contact'
  resources :venues do
    resources :reviews
  end
  devise_for :users, controllers: { registrations: :registrations }
  resources :users, only: :show
end
