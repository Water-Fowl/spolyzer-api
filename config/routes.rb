Rails.application.routes.draw do
    namespace :api do
    namespace :v1 do
        mount_devise_token_auth_for 'User', at: 'auth', controllers: {
            registrations: 'api/v1/auth/registrations'
        }
        get  'actions/:position/:side/:score_game_id' to 'actions#show'
        get  'games/:user_id/:opponent_user/:victory' to 'games#show'
        get  'users/:name' to 'users#search_user_by_id'
        resources :games
        resources :actions
    end
  end

  resources :score_game_to_users
  resources :scores
  resources :score_games
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
