class NotificationsController < ApplicationController
  respond_to :html, :js, :json, :xml
  before_filter :authenticate_user!
  before_filter :load_project, :only => [:index, :create, :destroy]
  
  def index
    @notifications = @project.notifications
    respond_with(@notifiations)
  end
  
  def create
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