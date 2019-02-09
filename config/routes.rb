Rails.application.routes.draw do
  root 'base#index'

  namespace :admin do
    root 'admin#index'
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    resources :articles, only: [:index]
  end
end
