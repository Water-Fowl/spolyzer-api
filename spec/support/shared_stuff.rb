# frozen_string_literal: true

RSpec.configure do |rspec|
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context 'header', shared_context: :metadata do
  let!(:headers) { { 'Content-Type' => 'application/json', 'Accept' => 'application/json' } }
  let!(:user) { create(:user) }

  before do
    auth_header = user.create_new_auth_token
    headers.merge! auth_header
  end
end

RSpec.configure do |rspec|
  rspec.include_context 'header', include_shared: true
end
