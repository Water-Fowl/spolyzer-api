# frozen_string_literal: true

server '52.199.120.130', user: fetch(:user), roles: %w[web app db worker cron], primary: true
set :branch, 'v1.0.0'
set :stage, :staging
set :rails_env, :staging
set :ssh_keys, ['~/.ssh/id_rsa']
set :ssh_options,
    keys: fetch(:ssh_keys).map { |x| File.expand_path(x) },
    forward_agent: true
