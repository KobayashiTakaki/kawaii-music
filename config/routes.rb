Rails.application.routes.draw do
  root 'base#index'

  resources :tracks, only: [:index]
  resources :genres, only: [:show]
  namespace :admin do
    root 'admin#index'
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    resources :users, only: [:edit, :update]
    resources :tracks, only: [:index, :edit, :update, :destroy] do
      resources :genres, only: [:create, :destroy]
      resources :tags, only: [:create, :destroy]
      collection {post :import}
    end
    resources :genres, only: [:index, :show, :destroy]
    resources :tags, only: [:index, :show, :destroy]

  end
end
