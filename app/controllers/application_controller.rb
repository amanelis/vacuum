class ApplicationController < ActionController::Base
  after_filter :set_access_control_headers
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied."
    redirect_to root_path
  end

  rescue_from Mongoid::Errors::DocumentNotFound do |exception|
    flash[:alert] = "Document/url not found."
    redirect_to root_path
  end
  
  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end
end