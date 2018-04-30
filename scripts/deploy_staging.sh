cd capistrano
bundle install --path ./vendor/bundle
bundle exec cap staging deploy
