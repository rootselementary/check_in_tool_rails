Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions',
                                   omniauth_callbacks: 'users/omniauth_callbacks'}
  root 'home#index'

  namespace :admin do
    get '/dashboard', controller: 'dashboard', action: 'show', as: :dashboard
    get '/grove-monitor', controller: 'grove_monitor', action: 'show', as: :grove_monitor
    get '/grove-monitor-all', controller: 'grove_monitor', action: 'index', as: :grove_monitor_all
    patch '/grove-monitor-all', controller: 'grove_monitor', action: 'update', as: :update_grove_monitor_all
    get '/grove-playlist-manager', controller: 'playlists', action: 'index', as: :grove_playlist_manager
    resources :groves
    resources :locations
    resources :teachers
    resources :students do
      get '/playlist', controller: 'playlist_activities', action: 'index'
      resources :playlist_activities, except: [:show]
    end
    resources :activities
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :admin do
        resources :students, only: [] do
          patch '/playlist_activities', controller: 'students/playlist_activities', action: 'update'
        end
      end
    end

  namespace :callbacks do
    get '/notifications', controller: 'google', action: 'watch'
  end

  get '/compass', controller: 'compass', action: 'show', as: :compass
  get '/logout', controller: 'compass', action: 'logout', as: :logout
  get '/checkin', to: 'compass#checkin'
end
