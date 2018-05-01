Rails.application.routes.draw do

  namespace :api, format: 'json' do
    namespace :v1 do
        mount_devise_token_auth_for 'User', at: 'auth', controllers: {
          registrations: 'api/v1/auth/registrations'
        }
        resources :positions do
          collection do
            get :counts
          end
        end

        resources :users  do
          collection do
            get :search
          end
        end

        resources :games, only: [:index, :create]  do
          resources :aggregated_scores, only: [:index], module: 'games'
        end

        resources :shot_types do
          resources :aggregated_scores, only: [:index], module: 'shot_types'
        end

        resources :analytics
        resources :analysis_results
    end
  end

  get '/admin', to: 'admin/dashboard#index'
  get '/redirect/confirmation', to: 'redirect/confirmation#index'
  namespace :admin do
  end
end
