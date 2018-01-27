Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
        mount_devise_token_auth_for 'User', at: 'auth', controllers: {
            registrations: 'api/v1/auth/registrations'
        }
        resources :shot_types
        resources :games
        resources :users
    end
  end

  resources :score_game_to_users
  resources :scores
  resources :score_games

  get '/admin', to: 'admin/dashboard#index'
  namespace :admin do
  end
end
