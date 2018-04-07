require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

# for auto documentation
Autodoc.configuration.toc_html = true
Autodoc.configuration.suppressed_response_header = ['Cache-Control', 'Content-Length', 'X-Request-Id', 'X-Runtime', 'X-XSS-Protection', 'ETag', 'Content-Type', 'X-Content-Type-Options', 'X-Frame-Options']
Autodoc.configuration.suppressed_request_header = %w[Accept Content-Length Content-Type Host]

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include RSpec::RequestDescriber, type: :request
  config.include RequestHelpers, type: :request
  config.include RequestMacros, type: :request

  config.before :all do
    FactoryGirl.reload
  end

  config.before :suite do
    DatabaseRewinder.clean_all
    Rails.application.load_seed
  end
end
