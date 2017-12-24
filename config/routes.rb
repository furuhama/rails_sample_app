Rails.application.routes.draw do
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, only: %i[index edit show update destroy] do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  # API用
  namespace :api, {format: 'json'} do
    namespace :v1 do
      namespace :users do
        get "/" , :action => "index"
      end
    end
  end

  # admin
  namespace :admin do
    resource :dashboard, only: [:show]
  end

  # maintainer
  namespace :maintainer do
    resource :dashboard, only: [:show]
  end
end
