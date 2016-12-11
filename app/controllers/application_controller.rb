class ApplicationController < ActionController::Base
  include Clearance::Controller

  protect_from_forgery with: :null_session

  helper_method :token
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  
  private

  def render_errors(errors)
    render json: { errors: errors }, status: 422
  end

  def token
    authenticate_or_request_with_http_token do |token, options|
      token
    end  
  end

  def record_not_found
    render :json => {:result => 'record not found'} # Assuming you have a template named 'record_not_found'
  end

end
