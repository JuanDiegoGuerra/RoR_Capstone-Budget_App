Rails.application.routes.draw do
  devise_for :users
    resources :groups, only: [:index, :new, :create, :show, :destroy], path: 'categories' do
    resources :purchases, only: [:new, :create ], path: 'transactions'
  end
  resources :groups, only: [:index, :new, :create, :show]
  root 'groups#index'
end
