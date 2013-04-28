class NotificationsController < ApplicationController
  respond_to :html, :js, :json, :xml
  before_filter :authenticate_user!
  rescue_from Mongoid::Errors::DocumentNotFound, :with => :not_found
  
  def index
    @project = current_user.projects.find(params[:project_id])
    @notifications = @project.notifications
    respond_with(@notifiations)
  end
  
  def create
    @project = current_user.projects.find(params[:project_id])
    @notification = @project.notifications.build(name: params[:name], email: params[:email])    
    if @notification.save
      respond_to do |format|
        format.json { render :json => @notification.to_json, :status => 201 }
        format.js   { render :json => @notification.to_json, :status => 201 }
        format.xml  { render :xml  => @notification.to_xml,  :status => 201 }
      end
    end
  end
  
  def destroy
    @project = current_user.projects.find(params[:project_id])
    @notification = @project.notifications.find(params[:id])
    
    if @notification.destroy
      flash[:success] = "User successfully deleted."
      redirect_to "/projects/#{@project.id}#notification"
    else
      flash[:alert] = "Ooops, #{@notification.errors.messages.collect { |k,v| "#{k.upcase} #{v.first}" }.join(',').gsub(',', ', ')}"
      redirect_to project_notifications_path(@project)
    end
  end
  
  private
    def not_found
      flash[:alert] = "You do not have access to view that project and its data."
      redirect_to projects_path
    end
end