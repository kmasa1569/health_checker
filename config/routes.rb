Rails.application.routes.draw do
  root to: 'sessions#new'
  post '/', to: 'sessions#create'
  delete '/', to: 'sessions#destroy'
  namespace :admin do
    resources :users
  end
  resources :users, except: [:new, :create] do
    resources :checklists
  end
  resources :password_resets, only: [:new, :create, :edit, :update]
end
