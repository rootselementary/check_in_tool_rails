Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions',
                                   omniauth_callbacks: 'users/omniauth_callbacks'}
  root 'home#index'

  namespace :admin do
    get '/dashboard', controller: 'dashboard', action: 'show', as: :dashboard
    get '/grove-monitor', controller: 'grove_monitor', action: 'show', as: :grove_monitor
    get '/grove-playlist-manager', controller: 'playlists', action: 'index', as: :grove_playlist_manager
    resources :groves
    resources :teachers
    resources :students, only: [] do
      resource :playlist, only: [:show]
    end
  end

  get '/compass', controller: 'compass', action: 'show', as: :compass
  get '/logout', controller: 'compass', action: 'logout', as: :logout
end
