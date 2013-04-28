class Api::V1::ProjectsController < Api::V1::ApiController  
  before_filter :clean_params,    :only => [:index, :create]
  before_filter :load_project,    :only => [:index, :create]
    
  # index
  # This method will return a site {} hash as well as log_entries {} 
  # hash of data for the given api_key's site's log entries.
  def index
    @project = Project.where(api_key: params[:api_key])[0]
    render json: {project: @project.as_json(only: project_permissions(:only))}, status: 200, callback: params[:callback]
  end
end