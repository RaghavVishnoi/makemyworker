module ApiHelpers
  def json_body
    JSON.parse(response.body)
  end

  def authorized_headers(token)
    token_header_value = ActionController::HttpAuthentication::Token.encode_credentials(token)
    unauthorized_headers.merge("Authorization" => token_header_value)
  end
end

RSpec.configure do |config|
  config.include ApiHelpers, type: :request
end
