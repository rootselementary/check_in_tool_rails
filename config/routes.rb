Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions'}
  root 'home#index'

  namespace :admin do
    get '/dashboard', controller: 'dashboard', action: 'show', as: :dashboard
    get '/grove-monitor', controller: 'grove_monitor', action: 'show', as: :grove_monitor
    get '/grove-playlist-manager', controller: 'grove_playlist', action: 'show', as: :grove_playlist
    resources :groves
  end

  get '/compass', controller: 'compass', action: 'show', as: :compass
  get '/logout', controller: 'compass', action: 'logout', as: :logout
end
