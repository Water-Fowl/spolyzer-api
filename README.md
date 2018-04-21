# README

## Set up

```
git clone https://github.com/Water-Fowl/api.git
cp yamadからもらった.env path/to/project
cd path/to/project
bundle install --path vendor/bundle
bundle exec rails db:create db:migrate db:seed
```

## Run

```
bundle exec rails s
```

## Clean Data

```
bundle exec rails db:drop db:create db:migrate db:seed
```
