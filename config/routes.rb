Rails.application.routes.draw do
  resources :users, except: [:new, :create] do
    resources :checklists
  end
  root to: 'sessions#new'
  post '/', to: 'sessions#create'
  delete '/', to: 'sessions#destroy'
  namespace :admin do
    resources :users
  end
  resources :password_resets, only: [:new, :create, :edit, :update]
end
