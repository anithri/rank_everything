# frozen_string_literal: true

module SessionTestHelper
  def sign_in_as(user)
    # 1. Create a new user session for the provided user.
    Current.session = user.sessions.create!

    # 2. Build a cookie jar with the new session ID.
    ActionDispatch::TestRequest.create.cookie_jar.tap do |cookie_jar|
      cookie_jar.signed[:session_id] = Current.session.id
      cookies[:session_id] = cookie_jar[:session_id]
    end
  end
end
