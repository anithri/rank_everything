# frozen_string_literal: true

require_relative '../request_helpers'

RSpec.shared_examples "unauthenticated requests", type: :request do |method, path|
  include RequestHelpers

  it "redirects #{method.to_s.upcase} #{path} to the login page" do
    make_request(method, path)

    expect(response).to redirect_to('/session/new')
  end
end
