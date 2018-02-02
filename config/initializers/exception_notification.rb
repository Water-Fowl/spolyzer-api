require 'exception_notification/rails'

ExceptionNotification.configure do |config|
  config.ignore_if do |exception, options|
    Rails.env.development?
  end

  config.add_notifier :slack, {
   webhook_url: Rails.application.secrets.slack_webhook_url,
  }
  config.ignored_exceptions = ''
end

Rails.application.config.middleware.use ExceptionNotification::Rack,
  :ignore_crawlers => %w{Googlebot bingbot}
