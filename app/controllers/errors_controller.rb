class ErrorsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_project, :only => [:index, :show, :group_resolve, :resolve]
  before_filter :load_error,   :only => [:show, :resolve]
  respond_to :html, :js

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied for that projects data."
    redirect_to root_path
  end

  def index
    authorize! :read, @project
    @errors  = @project.errors.unresolved.desc(:updated_at).paginate(page: params[:page], per: 10)
  end

  def show
    authorize! :read, @error
    @occurrences = @error.occurrences.desc(:updated_at).paginate(page: params[:page], per: 10)
  end

  def group_resolve
    authorize! :resolve, @project
    error_ids = params[:error_ids]
    error_ids.each do |id|
      @project.errors.find(id).update_attributes!(resolved: true)
    end
    redirect_to project_errors_path(@project)
  end

  def resolve
    authorize! :resolve, @project
    @error.update_attributes!(resolved: params[:error][:resolved])
    render nothing: true
  end

  private
    def load_project
      @project = current_user.projects.find(params[:project_id])
    end

    def load_error
       @error = @project.errors.find(params[:id])
    end
end