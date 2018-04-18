source 'http://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'mysql2', '>= 0.3.18', '< 0.5'

gem 'devise_token_auth'
gem 'devise'
gem 'omniauth'

gem 'unicorn'
gem 'unicorn-worker-killer'

# for static data
gem 'active_hash'

gem 'dotenv-rails'

gem 'aws-sdk', '2.0.6.pre'

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'haml-rails'
gem 'erb2haml'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

gem 'exception_notification'
gem 'slack-notifier'
gem 'activerecord-session_store'
gem 'carrierwave'
gem 'fog'
gem 'config'

source 'https://rails-assets.org' do
  gem 'rails-assets-toastr'
  gem 'rails-assets-flexslider'
end
gem 'bootstrap-sass'
gem "font-awesome-rails"
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'sass-rails'
gem 'fancybox2-rails'
gem 'sprockets-rails'

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_rewinder'
  gem 'rspec-request_describer'
  gem 'autodoc'
  gem 'redcarpet'
  gem 'rspec-json_matcher'
  gem 'faker'
  gem 'timecop'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'rails-erd'
  gem 'rubocop', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
