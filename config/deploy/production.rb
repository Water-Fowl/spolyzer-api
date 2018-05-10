# frozen_string_literal: true

server '54.249.94.110', user: fetch(:user), roles: %w[web app db worker cron], primary: true
set :branch, 'master'
set :stage, :production
set :rails_env, :production
set :ssh_keys, ['deploy_key']
set :ssh_options,
    keys: fetch(:ssh_keys).map { |x| File.expand_path(x) },
    forward_agent: true
