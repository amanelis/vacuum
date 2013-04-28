class ApplicationController < ActionController::Base
  after_filter :set_access_control_headers
  
  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end
  
  # before_filter :mailer_set_url_options
  # def mailer_set_url_options
  #   ActionMailer::Base.default_url_options[:host] = request.host_with_port
  # end
end