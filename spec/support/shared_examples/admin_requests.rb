# frozen_string_literal: true

require_relative '../request_helpers'

RSpec.shared_examples "successful request" do |path, user, status = 200|
  before { sign_in_as(user) }

  it "to #{path}" do
    get path

    expect(response).to have_http_status(status)
  end
end
RSpec.shared_examples "admin requests", type: :request do |base_path, user, id|
  include RequestHelpers

  before { sign_in_as(user) }

  include_examples "successful request", base_path, admin
  include_examples "successful request", "#{base_path}/new", admin
  include_examples "successful request", "#{base_path}/#{id}", admin
  include_examples "successful request", "#{base_path}/#{id}/edit", admin
end
