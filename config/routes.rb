Rails.application.routes.draw do

  namespace :api, format: 'json' do
    namespace :v1 do
        mount_devise_token_auth_for 'User', at: 'auth', controllers: {
          registrations: 'api/v1/auth/registrations'
        }
        get 'positions/counts', to: 'positions#show'
        resources :shot_types
        resources :games
        resources :users
        resources :analytics
        resources :analysis_results
    end
  end

  get '/admin', to: 'admin/dashboard#index'
  namespace :admin do
  end
end
