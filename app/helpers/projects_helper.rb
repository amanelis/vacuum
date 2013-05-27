module ProjectsHelper
  def create_project(params)
    if params[:project][:name].nil? || params[:project][:name].empty? ||
      params[:project][:url].nil? || params[:project][:url].empty?
      flash[:error] = "Incorrect parameters missing or passed. Please try again."
      redirect_to new_project_path
      return false
    end
    
    @project = current_user.projects.build(params[:project])
    
    if @project.save
      flash[:success] = "Awesome! Lets get you logging some errors now."
      redirect_to project_path(@project)
    else
      flash[:alert] = "Ooops, #{@project.errors.messages.collect { |k,v| "#{k.upcase} #{v.first}" }.join(',').gsub(',', ', ')}"
      render :new 
    end
  end
  
  def new_project
    @project = current_user.projects.build
  end
  
  def update_project(project, params)
    if project.update_attributes!(params[:project])
      flash[:success] = "Project successfully updated."
    else
      flash[:alert] = "Ooops, #{project.errors.messages.collect { |k,v| "#{k.upcase} #{v.first}" }.join(',').gsub(',', ', ')}"
    end
    
    redirect_to project_path(project, anchor: 'settings')
  end
  
  def destroy_project(project)
    if project.destroy
      flash[:success] = "Project successfully deleted."
      redirect_to projects_path
    else
      flash[:alert] = "Ooops, #{project.errors.messages.collect { |k,v| "#{k.upcase} #{v.first}" }.join(',').gsub(',', ', ')}"
      redirect_to project_path(project)
    end
  end
  
  def load_project
    @project = current_user.projects.find(params[:id])
  end
  
  def project_read_deny
    "Permission denied."
  end
  
  def project_create_deny(current_user)
    "You need to upgrade your account before you can add more projects."
  end
end
