Rails.application.routes.draw do
  devise_for :users
  root to: 'articles#index'
  resources :articles, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
    collection do
      get "search"
    end
  end
end
