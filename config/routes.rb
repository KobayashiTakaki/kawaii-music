Rails.application.routes.draw do
  root 'base#index'

  namespace :admin do
    root 'base#index'
  end
end
