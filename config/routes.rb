Rails.application.routes.draw do
  resources :users, except: [:new, :create]
  resources :checklists
  root to: 'sessions#new'
  post '/', to: 'sessions#create'
  delete '/', to: 'sessions#destroy'
  namespace :admin do
    resources :users
  end
end
