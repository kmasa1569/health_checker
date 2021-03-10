Rails.application.routes.draw do
  resources :checklists
  root to: 'sessions#new'
  post '/', to: 'sessions#create'
  delete '/', to: 'sessions#destroy'
  namespace :admin do
    resources :users
    get '/patients', to: 'users#index_p'
  end
end
