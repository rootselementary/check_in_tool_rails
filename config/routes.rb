Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions',
                                   omniauth_callbacks: 'users/omniauth_callbacks'}
  root 'home#index'

  namespace :admin do
    get '/dashboard', controller: 'dashboard', action: 'show', as: :dashboard
    resources :groves
  end

  get '/compass', controller: 'compass', action: 'show', as: :compass
  get '/logout', controller: 'compass', action: 'logout', as: :logout
end
