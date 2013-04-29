class NotificationsController < ApplicationController
  respond_to :html, :js, :json, :xml
  before_filter :authenticate_user!
  
  def index
    @project = current_user.projects.find(params[:project_id])
    @notifications = @project.notifications
    respond_with(@notifiations)
  end
  
  def new
    @notification = Notification.new
    render layout: false
  end
  
  def create
    if params[:name].present? && params[:email].present?
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
end