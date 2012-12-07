class ErrorsController < ApplicationController
  before_filter :load_project, :only => [:index]
  
  def index
    @errors = @project.errors.desc(:updated_at).paginate(page: params[:page], per: params[:per])
  end
  
  protected
    def load_project
      @project = Project.where(id: params[:project_id]).first
    end
end