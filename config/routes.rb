Rails.application.routes.draw do
  devise_for :users
  root to: 'articles#index'
  resources :articles do
    resources :favorites, only: [:index, :create]
    collection do
      get "search"
    end
  end
end
