class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_project, :only => [:index, :show, :update, :destroy]
  respond_to :html, :js
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied for that action."
    redirect_to root_path
  end
  
  def index
    authorize! :read, Project
  end
  
  def new
    authorize! :create, Project
    @project = current_user.projects.build
  end
  
  def create
    authorize! :create, Project
    @project = current_user.projects.build(params[:project])
    
    if @project.save
      flash[:success] = "Awesome! Lets get you logging some errors now"
      redirect_to project_path(@project)
    else
      flash[:alert] = "Ooops, #{@project.errors.messages.collect { |k,v| "#{k.upcase} #{v.first}" }.join(',').gsub(',', ', ')}"
      render :new
    end
  end
  
  def show
    authorize! :read, @project
  end
  
  def update
    authorize! :update, @project
    
    if @project.update_attributes!(params[:project])
      flash[:success] = "Project successfully updated."
      redirect_to project_path(@project, anchor: 'settings')
    else
      flash[:alert] = "Ooops, #{@project.errors.messages.collect { |k,v| "#{k.upcase} #{v.first}" }.join(',').gsub(',', ', ')}"
      redirect_to project_path(@project, anchor: 'settings')
    end
  end
  
  def destroy
    authorize! :destroy, @project
    
    if @project.destroy
      flash[:success] = "Project successfully deleted."
      redirect_to projects_path
    else
      flash[:alert] = "Ooops, #{@project.errors.messages.collect { |k,v| "#{k.upcase} #{v.first}" }.join(',').gsub(',', ', ')}"
      redirect_to project_path(@project)
    end
  end
  
  private 
    def load_project
      if params[:action] == "index"
        @projects = current_user.projects.paginate(page: params[:page], per_page: 10)
      else
        # @project = current_user.projects.find(params[:id])
        @project = Project.find(params[:id])
      end
    end
end