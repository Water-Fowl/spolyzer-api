Rails.application.routes.draw do

  post 'user_token' => 'user_token#create'
  namespace :api, format: 'json' do
    namespace :v1 do
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
          resources :counts, only: [:index], module: 'games'
        end
        resources :shot_types do
          resources :counts, only: [:index], module: 'shot_types'
          namespace :counts, module: 'shot_types' do
            resources :opponent_users, only: [:show], param: :ids, module: 'counts'
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
