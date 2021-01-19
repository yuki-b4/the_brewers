Rails.application.routes.draw do
  devise_for :users
  root to: 'articles#index'
  resources :users do
    collection do
      get "bookmark_list"
    end
  end
  resources :articles do
    resource :favorites, only: [:create, :destroy]
    collection do
      get "search"
    end
  end
end
