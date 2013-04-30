class ErrorsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_project, :only => [:index, :show, :resolve]
  before_filter :load_error,   :only => [:show, :resolve]
  respond_to :html, :js 
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied for that projects errors."
    redirect_to root_path
  end
  
  def index
    authorize! :read, @project
    @errors  = @project.errors.desc(:updated_at).paginate(page: params[:page], per: 10)
  end
  
  def show
    authorize! :read, @error
    @occurrences = @error.occurrences.desc(:updated_at).paginate(page: params[:page], per: 10)
  end
  
  def resolve
    authorize! :resolve, @error
    @error.update_attributes!(resolved: params[:error][:resolved])
  end
  
  private
    def load_project
      @project = current_user.projects.find(params[:project_id])
    end
    
    def load_error
       @error = @project.errors.find(params[:id])
    end
end