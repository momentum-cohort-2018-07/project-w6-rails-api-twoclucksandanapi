Rails.application.routes.draw do
  namespace :api do
    resource :session, only: :create
    resources :users do
      resources :posts do
        resources :favorites
      end
      resources :followers
    end
  end 
end