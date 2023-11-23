Rails.application.routes.draw do
  devise_for :users
  resources :groups, only: [:index, :new, :create, :show]
  root 'groups#index'
end
