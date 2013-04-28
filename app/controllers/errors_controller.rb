class ErrorsController < ApplicationController
  respond_to :html, :js, :json, :xml
  before_filter :authenticate_user!
  rescue_from Mongoid::Errors::DocumentNotFound, :with => :not_found
  
  def index
    @project = current_user.projects.find(params[:project_id])
    @errors = @project.errors.desc(:updated_at).paginate(page: params[:page], per: 10)
  end
  
  def show
    @project = current_user.projects.find(params[:project_id])
    @error = Error.find(params[:id])
    @occurrences = @error.occurrences.desc(:updated_at).paginate(page: params[:page], per: 10)
  end
  
  def resolve
    @project = current_user.projects.find(params[:project_id])
    @error = Error.find(params[:id])
    @error.update_attributes!(resolved: params[:error][:resolved])
  end
  
  private
    def not_found
      flash[:alert] = "You do not have access to view that project and its data."
      redirect_to projects_path
    end
end