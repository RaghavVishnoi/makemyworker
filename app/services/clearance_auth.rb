class ClearanceAuth < ApplicationController
  
  def self.user_from_params(user_params)
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email.downcase
      user.password = password
    end
  end

  def self.authenticate(params)
    Clearance.configuration.user_model.authenticate(
    params[:user][:email],params[:user][:password]
    )
  end

  def self.find_user_for_create(email)
      Clearance.configuration.user_model.
      find_by_normalized_email email
  end

  def self.find_user_by_id_and_confirmation_token(params,token)
    user_param = Clearance.configuration.user_id_parameter
    Clearance.configuration.user_model.
    find_by_id_and_confirmation_token params[:user][user_param], token
  end

  def self.deliver_email(user)
      mail = ::ClearanceMailer.change_password(user)
      if Gem::Version.new(Rails::VERSION::STRING) >= Gem::Version.new("4.2.0")
        mail.deliver_later
      else
        mail.deliver
      end
    end


end