# frozen_string_literal: true

module RequestHelpers
  def make_request(method, path, params = {}, headers = {})
    case method.to_sym
    when :get
      get path, params: params, headers: headers
    when :post
      post path, params: params, headers: headers
    when :put
      put path, params: params, headers: headers
    when :patch
      patch path, params: params, headers: headers
    when :delete
      delete path, params: params, headers: headers # DELETE requests typically don't have a body but might have params in the path
    else
      raise ArgumentError, "Unsupported HTTP method: #{method}"
    end
  end
end
