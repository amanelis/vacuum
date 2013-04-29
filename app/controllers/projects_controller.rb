class ProjectsController < ApplicationController
  respond_to :html, :js, :json, :xml
  before_filter :authenticate_user!
  
  def index
    @projects = current_user.projects.paginate(page: params[:page], per_page: 10)
  end
  
  def new
    @project = current_user.projects.build
  end
  
  def create
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
    @project = current_user.projects.find(params[:id])
  end
  
  def update
    @project = current_user.projects.find(params[:id])
    
    if @project.update_attributes!(params[:project])
      flash[:success] = "Project successfully updated."
      redirect_to project_path(@project, anchor: 'settings')
    else
      flash[:alert] = "Ooops, #{@project.errors.messages.collect { |k,v| "#{k.upcase} #{v.first}" }.join(',').gsub(',', ', ')}"
      redirect_to project_path(@project, anchor: 'settings')
    end
  end
  
  def destroy
    @project = current_user.projects.find(params[:id])
    
    if @project.destroy
      flash[:success] = "Project successfully deleted."
      redirect_to projects_path
    else
      flash[:alert] = "Ooops, #{@project.errors.messages.collect { |k,v| "#{k.upcase} #{v.first}" }.join(',').gsub(',', ', ')}"
      redirect_to project_path(@project)
    end
  end
end