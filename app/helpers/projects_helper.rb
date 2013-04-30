module ProjectsHelper
  def create_project(params)
    @project = current_user.projects.build(params[:project])
    
    if @project.save
      flash[:success] = "Awesome! Lets get you logging some errors now"
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
    if params[:action] == "index"
      @projects = current_user.projects.paginate(page: params[:page], per_page: 10)
    else
      @project = Project.find(params[:id])
    end
  end
end
