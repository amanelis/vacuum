class NotificationsController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @notification = Notification.new
    render layout: false
  end
  
  def create
    @project = current_user.projects.find(params[:project_id])
    @notification = @project.notifications.build(name: params[:notification][:name], email: params[:notification][:email])
    
    if @notification.save
      flash[:success] = "Notification saved successfully."
    else
      flash[:alert] = "There was an error, please try again later."
    end
  
    redirect_to project_path(@project, anchor: 'notifications')
  end
  
  def destroy
    @project = current_user.projects.find(params[:project_id])
    @notification = @project.notifications.find(params[:id])
    
    if @notification.destroy
      flash[:success] = "User successfully deleted."
    else
      flash[:alert] = "Ooops, #{@notification.errors.messages.collect { |k,v| "#{k.upcase} #{v.first}" }.join(',').gsub(',', ', ')}"
    end
    
    redirect_to project_path(@project, anchor: 'notifications')
  end
end