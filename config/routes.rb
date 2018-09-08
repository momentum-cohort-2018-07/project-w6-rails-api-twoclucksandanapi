Rails.application.routes.draw do 
  namespace :api do
    resource :session, only: :create
    resources :users do
      resources :posts do
        delete 'favorites', to: 'favorites#destroy'
        post 'favorites', to: 'favorites#create'
        get 'favorites', to: 'favorites#index'
      end
      resources :followers
      get 'follows', to: 'followers#follows'
      get 'follows/:follows_id', to: 'followers#follows_show'
    end
  end 
end