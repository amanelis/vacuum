class ProjectsController < ApplicationController
  include ProjectsHelper
  before_filter :authenticate_user!
  before_filter :load_project, :only => [:index, :show, :update, :destroy]
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied."
    redirect_to root_path
  end
  
  def index
    authorize! :read, Project
  end
  
  def new
    authorize! :create, Project
    new_project
  end
  
  def create
    authorize! :create, Project
    create_project(params)
  end
  
  def show
    authorize! :read, @project
  end
  
  def update
    authorize! :update, @project
    update_project(@project, params)
  end
  
  def destroy
    authorize! :destroy, @project
    destroy_project(@project)
  end
end