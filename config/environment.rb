# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  user_name: 'waterfowl',
  password: 'PASSWORD',
  domain: '',
  address: '',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
ActionMailer::Base.raise_delivery_errors = true
