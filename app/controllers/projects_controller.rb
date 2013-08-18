class ProjectsController < ApplicationController
  include ProjectsHelper
  before_filter :authenticate_user!
  before_filter :load_project, :only => [:show, :update, :destroy]
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_path
  end
  
  def index
    @projects = current_user.projects.paginate(page: params[:page], per: 2)
    current_user.collaborators.collect { |c| @projects << c.project }
    authorize! :read, Project, message: project_read_deny
  end
  
  def new
    authorize! :create, Project, message: project_create_deny(current_user)
    new_project
  end
  
  def create
    authorize! :create, Project, message: project_create_deny(current_user)
    create_project(params)
  end
  
  def show
    authorize! :read, @project, message: project_read_deny
  end
  
  def update
    authorize! :update, @project, message: project_read_deny
    update_project(@project, params)
  end
  
  def destroy
    authorize! :destroy, @project, message: project_read_deny
    destroy_project(@project)
  end
end