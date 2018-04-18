# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  user_name: ENV['MAIL_USER_NAME'],
  password: ENV['MAIL_PASSWORD'],
  domain: ENV['MAIL_DOMAIN'],
  address: ENV['MAIL_ADDRESS'],
  port: 587,
  authentication: :plain,
  enable_starttls_auto: false
}
ActionMailer::Base.raise_delivery_errors = true
