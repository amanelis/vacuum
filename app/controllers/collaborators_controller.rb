class CollaboratorsController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @collaborator = Collaborator.new
    render layout: false
  end
  
  def create
    @project  = current_user.projects.find(params[:project_id])
    password  = Devise.friendly_token[0,10]
    @user     = User.find_or_create_by(email: params[:collaborator][:email])
    
    if @user.sign_in_count == 0
      @user.update_attributes!(password: password, password_confirmation: password)
      UserMailer.delay.temp_password(@user, password)
    end
    
    @collaborator   = @project.collaborators.build(email: @user.email, user_id: @user.id)
    
    if @collaborator.save
      flash[:success] = "Collaborator saved successfully."
    else
      flash[:alert] = "There was an error, please try again later."
    end
  
    redirect_to project_path(@project, anchor: 'collaborators')
  end
  
  def destroy
    @project = current_user.projects.find(params[:project_id])
    @collaborator = @project.collaborators.find(params[:id])
    
    if @collaborator.destroy
      flash[:success] = "Collaborator successfully deleted."
    else
      flash[:alert] = "Ooops, #{@collaborator.errors.messages.collect { |k,v| "#{k.upcase} #{v.first}" }.join(',').gsub(',', ', ')}"
    end
    
    redirect_to project_path(@project, anchor: 'collaborators')
  end
end
