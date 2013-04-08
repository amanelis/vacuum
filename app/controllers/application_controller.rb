class ApplicationController < ActionController::Base
  after_filter :set_access_control_headers
  
  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end
  
  def load_project
    @project = Project.find(params[:project_id])
  end
end