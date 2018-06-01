# frozen_string_literal: true

source 'http://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'rails', '~> 5.1.4'

gem 'activeadmin'
gem 'devise'
gem 'devise_token_auth'
gem 'omniauth'

# Plus integrations with:
gem 'cancan' # or cancancan
gem 'draper'
gem 'pundit'

gem 'unicorn'
gem 'unicorn-worker-killer'

# for static data
gem 'active_hash'

gem 'dotenv-rails'

gem 'aws-sdk', '2.0.6.pre'

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'erb2haml'
gem 'haml-rails'
gem 'jbuilder', '~> 2.5'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

gem 'activerecord-session_store'
gem 'carrierwave'
gem 'config'
gem 'exception_notification'
gem 'fog'
gem 'slack-notifier'

# capistrano
gem 'capistrano', '3.9.1'
gem 'capistrano-bundler'
gem 'capistrano-dotenv-tasks', require: false
gem 'capistrano-rails'
gem 'capistrano-rbenv'
gem 'dotenv'

# gem 'capistrano-sidekiq'
gem 'capistrano3-unicorn', git: 'https://github.com/tablexi/capistrano3-unicorn.git', branch: 'master'
# gem 'whenever', require: false

gem 'sitemap_generator'
gem 'slackistrano'

source 'https://rails-assets.org' do
  gem 'rails-assets-flexslider'
  gem 'rails-assets-toastr'
end
gem 'bootstrap-sass'
gem 'coffee-rails', '~> 4.2'
gem 'fancybox2-rails'
gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'sass-rails'
gem 'sprockets-rails'

group :test do
  gem 'autodoc'
  gem 'database_cleaner'
  gem 'database_rewinder'
  gem 'database_rewinder'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'redcarpet'
  gem 'rspec-json_matcher'
  gem 'rspec-rails'
  gem 'rspec-rails'
  gem 'rspec-request_describer'
  gem 'rspec-request_describer'
  gem 'timecop'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rails-erd'
  gem 'rubocop', require: false
  gem 'travis'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
