class Api::V1::ApisController < ApplicationController
  before_action :authenticate
  # around_action :set_time_zone

  helper_method :current_user

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      sign_in(token)
    end
  end

  def set_time_zone(&block)
    if current_user
      Time.use_zone(current_user.time_zone_name, &block)
    else
      yield
    end
  end

  def sign_in(token)
    @current_user = User.find_by(token: token)
  end

  def current_user
    @current_user 
  end
end
