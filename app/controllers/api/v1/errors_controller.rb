class Api::V1::ErrorsController < Api::V1::ApiController  
  before_filter :clean_params,    :only => [:index, :create]
  before_filter :load_project,    :only => [:index, :create]
  
  def create    
    logger.debug ""
    logger.debug "PROJECT[#{@project.name}][ERROR] -------------------------------------------------------------------"
    logger.debug @params.inspect
    logger.debug "PROJECT[#{@project.name}][ERROR] -------------------------------------------------------------------"
    logger.debug ""
    
    # Find the Error or create it, then handle the occurence
    @error = Error.find_or_create_by(project_id: @project.id, level: params[:level], message: params[:message])    
    
    # Update the count if we are needing to add another occurence, else just continue
    # and add the first occurence
    @error.update_attributes!(count: (@error.count + 1)) unless @error.new_record?
    
    # Occurrence attributes
    occurrence_attributes = {
      app_name:         @params['app_name'],
      user_agent:       @params['user_agent'],
      parent_url:       @params['parent_url'],
      platform:         @params['platform'],
      parameters:       @params['parameters'],
      cookie_enabled:   @params['cookie_enabled'],
      line:             @params['line'],
      stack_trace:      @params['stack_trace'],
      created_at:       DateTime.now,
      updated_at:       DateTime.now
    }
    
    # Build the occurrence
    @occurrence = @error.occurrences.build(occurrence_attributes)
    
    # Save the resource, account for errors
    @error.save && @occurrence.save
    
    json = {
      error: @error.as_json(only: error_permissions(:only))
    }
    render json: json, response: 200, callback: params[:callback]
  end
end