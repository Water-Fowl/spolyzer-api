# frozen_string_literal: true

########## Update me ##########
set :application, 'spolyzer'
append :linked_files, '.env'
set :repo_url, 'https://yamad07:Yusuke0307@github.com/Water-Fowl/api.git'
set :user, 'admin'
set :rbenv_type, :user
set :rbenv_ruby, '2.4.3'

###############################

lock '3.9.1'

# optional
set :unicorn_config_path, 'config/unicorn.rb'
# set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
# set :whenever_roles, -> { :cron }
# set :sidekiq_config, "/home/#{fetch(:user)}/apps/#{fetch(:application)}/current/config/sidekiq.yml"

# common
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/shared public/uploads]
append :linked_dirs, '.bundle'
