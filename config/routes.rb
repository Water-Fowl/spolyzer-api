Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'aims/create'
    end
  end

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
        resources :users do
          collection do
            get :search
          end
        end
        resources :games do
          resources :aggregated_scores, only: [:index], module: 'games'
        end

        resources :shot_types
        namespace :aggregated_scores do
          resources :shot_types do
            resources :opponent_users, only: [:show], params: :ids, module: 'shot_types' do
            end
          end
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
