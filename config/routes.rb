Rails.application.routes.draw do
  namespace :admin do
    get 'genres/index'
    get 'genres/show'
  end
  root 'base#index'

  namespace :admin do
    root 'admin#index'
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    resources :articles, only: [:index]
    resources :tracks, only: [:index, :edit, :update] do
      collection {post :import}
    end
    resources :genres, only: [:index, :show]

  end
end
