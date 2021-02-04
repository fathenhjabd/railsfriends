Rails.application.routes.draw do
  resources :posts
  devise_for :users
  resources :friends
  #get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #root 'home#index'
  root 'posts#index'
  get 'home/about'
end
