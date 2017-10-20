Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
       mount_devise_token_auth_for 'User', at: 'auth'
       post 'show_by_position', controller: 'actions'
       resources :games
       resources :actions
    end
  end

  resources :score_game_to_users
  resources :scores
  resources :score_games
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
