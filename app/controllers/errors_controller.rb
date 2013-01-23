class ErrorsController < ApplicationController
  respond_to :html, :js, :json, :xml
  before_filter :authenticate_user!
  before_filter :load_project, :only => [:index, :show]
  
  def index
    @errors = @project.errors.desc(:updated_at).paginate(page: params[:page], per: 10)
  end
  
  def show
    @error = Error.find(params[:id])
    @occurrences = @error.occurrences.desc(:updated_at).paginate(page: params[:page], per: 10)
  end
  
  protected
    def load_project
      @project = Project.find(params[:project_id])
    end
end
