class ApplicationController < ActionController::Base
  def load_project
    @project = Project.find(params[:project_id])
  end
end