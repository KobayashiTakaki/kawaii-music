Rails.application.routes.draw do
  root 'base#index'

  resources :tracks, only: [:index]
  namespace :admin do
    root 'admin#index'
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    resources :articles, only: [:index]
    resources :tracks, only: [:index, :edit, :update, :destroy] do
      resources :genres, only: [:create, :destroy]
      resources :tags, only: [:create, :destroy]
      collection {post :import}
    end
    resources :genres, only: [:index, :show]
    resources :tags, only: [:index, :show]

  end
end
