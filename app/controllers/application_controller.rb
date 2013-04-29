class ApplicationController < ActionController::Base
  after_filter :set_access_control_headers

  rescue_from Mongoid::Errors::DocumentNotFound do |exception|
    flash[:alert] = "Document not found."
    redirect_to root_path
  end
  
  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end
end