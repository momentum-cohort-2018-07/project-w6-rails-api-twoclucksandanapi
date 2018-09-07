Rails.application.routes.draw do
  namespace :api do
    get 'favorites/index'
    get 'favorites/create'
    get 'favorites/destroy'
  end
  namespace :api do
    get 'followers/index'
    get 'followers/show'
    get 'followers/delete'
  end
  namespace :api do
    get 'users/index'
    get 'users/show'
    get 'users/update'
    get 'users/destroy'
  end
  namespace :api do
    get 'sessions/create'
  end
  namespace :api do
    resource :session
    resources :users do
      resources :posts do
        resources :favorites
      end
      resources :followers
    end
  end 
end