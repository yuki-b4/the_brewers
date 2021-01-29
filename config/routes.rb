Rails.application.routes.draw do
  devise_for :users
  root to: 'articles#index'
  resources :users, only: [:show, :edit, :update] do
    collection do
      get "bookmark_list"
    end
  end
  resources :articles do
    resource :favorites, only: [:create, :destroy]
    resources :reviews, only: [:create]
    collection do
      get "confirm"
      get "search"
    end
  end
end
