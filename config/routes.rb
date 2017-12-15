Rails.application.routes.draw do
    namespace :api do
    namespace :v1 do
        mount_devise_token_auth_for 'User', at: 'auth', controllers: {
            registrations: 'api/v1/auth/registrations'
        }
        post 'show_by_position', controller: 'actions'
        get  'actions/:position/:side/:score_game_id' to 'actions#show'
        post 'show_by_status', controller: 'actions'
        get  'games/:user_id/:opponent_user/:victory' to 'games#show'
        post 'search_user_by_id', controller: 'users'
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
