# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'my_app_name'
set :repo_url, 'git@example.com:me/my_repo.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :aws_region, ENV['AWS_REGION'] || 'ap-northeast-1'
set :aws_tag_role, ENV['AWS_TAG_ROLE'] || 'rails'
set :deploy_user, ENV['DEPLOY_USER'] || 'ec2-user'
set :deploy_ssh_keys, ENV['DEPLOY_SSH_KEYS'] || '~/.ssh/yamad07.pem'
# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'
set :deploy_to, "/var/apps/#{fetch(:application)}"
set :branch, ENV['BRANCH'] || 'master'
# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_files, fetch(:linked_files, []).push('config/settings/production.yml')
# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle')
set :rbenv_type, :user # :system or :user
set :rbenv_ruby, '2.2.2'
set :rbenv_prefix, "#{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_roles, :all # default value

set :rails_env, 'production'
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }
set :unicorn_config_path, "config/unicorn.rb"
set :unicorn_rack_env, 'deployment' # "development", "deployment", or "none"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end

  after :publishing, :restart
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
