class IncomingMailsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate_cloudmailin, only: [:create]

  def create
    Rails.logger.debug params.inspect
    Rails.logger.debug "Received: #{params[:headers][:subject]} for #{params[:envelope][:to]}"

    if ENV['CLOUDMAILIN_ADDRESS'].blank? || params[:envelope][:to] == ENV['CLOUDMAILIN_ADDRESS']
      head :created
    else
      render plain: "Unknown user #{params[:envelope][:to]}", status: :not_found
    end
  end

  protected

  def authenticate_cloudmailin
    auth = authenticate_with_http_basic do |username, password|
      username == 'cloudmailin' && password == (ENV['password'] || 'password')
    end
    return true if auth

    render plain: "Invalid credentials", status: :unauthorized
  end
end
