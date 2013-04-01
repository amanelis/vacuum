class ErrorsController < ApplicationController
  respond_to :html, :js, :json, :xml
  before_filter :authenticate_user!
  before_filter :load_project, :only => [:index, :show, :resolve]
  
  def index
    @errors = @project.errors.desc(:updated_at).paginate(page: params[:page], per: 10)
  end
  
  def show
    @error = Error.find(params[:id])
    @occurrences = @error.occurrences.desc(:updated_at).paginate(page: params[:page], per: 10)
  end
  
  def resolve
    @error = Error.find(params[:id])
    @error.update_attributes!(resolved: params[:error][:resolved])
  end
end