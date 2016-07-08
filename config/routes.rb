Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions'}
  devise_scope :user do
    get '/users/logout', controller: 'users/sessions', action: 'logout', as: :user_logout
  end
  root 'home#index'

  namespace :admin do
    get '/dashboard', controller: 'dashboard', action: 'show', as: :dashboard
  end

  get '/compass', controller: 'compass', action: 'show', as: :compass
end
