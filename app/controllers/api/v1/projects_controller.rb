class Api::V1::ProjectsController < Api::V1::ApiController  
  before_filter :clean_params,    :only => [:index, :create]
  before_filter :load_project,    :only => [:index, :create]
    
  # index
  # This method will return a site {} hash as well as log_entries {} 
  # hash of data for the given api_key's site's log entries.
  def index
    json = {
      project: @project.as_json(only: project_permissions(:only))
    }
    render json: json, response: 200, callback: params[:callback]
  end
  
  # create
  # Used to post up a log entry
  def create    
    logger.debug ""
    logger.debug "PROJECT[#{@project.name}][ERROR] -------------------------------------------------------------------"
    logger.debug @params.inspect
    logger.debug "PROJECT[#{@project.name}][ERROR] -------------------------------------------------------------------"
    logger.debug ""
    
    render nothing: true
    # @error = Error.find_or_create_by(site_id: @site._id, level: params[:level], message: params[:message])
    # @error.update_attributes!(count: (@error.count + 1)) unless @error.new_record?
    # 
    # json = {
    #   error: @error.as_json(only: error_permissions(:only))
    # }
    # render json: json, response: 200, callback: params[:callback]
  end
  
  protected
    # clean_parameters!
    # @param
    # @return
    # modifies the params! hash and removes any nast attributes sent not wanted
    # DEFAULT_ALLOWED_PARAMETERS_ON_LOGGING -> config/initializers/globals
    def clean_params
      @params = params.select { |k,v| DEFAULT_ALLOWED_PARAMETERS_ON_LOGGING.include?(k) }
    end
    
    # load_project
    # @param
    # @return
    # within this method, we can load the site and its corresponding account information
    def load_project
      @project = Project.where(api_key: params[:api_key]).first
    end
end