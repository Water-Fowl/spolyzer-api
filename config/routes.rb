Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :score_game_to_users
  resources :scores
  resources :score_games
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
