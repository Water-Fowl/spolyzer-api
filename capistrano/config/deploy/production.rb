server '128.199.68.200:57854', user: fetch(:user), roles: %w{ web app db worker cron }, primary: true
set :branch, 'v1.0.0'
set :stage, :production
set :rails_env, :production
set :ssh_keys, ['~/.ssh/id_rsa']
set :ssh_options, {
  keys: fetch(:ssh_keys).map { |x| File.expand_path(x) },
  forward_agent: true
}
