class Api::V1::ErrorsController < Api::V1::ApiController  
  before_filter :clean_params,    :only => [:index, :create]
  before_filter :load_project,    :only => [:index, :create]
  
  def create        
    # Find the Error or create it, then handle the occurence
    @error = Error.find_or_create_by(project_id: @project.id, level: params[:level], message: params[:message])    
    
    # Update the count if we are needing to add another occurence, else just continue
    # and add the first occurence
    @error.update_attributes!(count: (@error.count + 1)) unless @error.new_record?
    
    # Occurrence attributes
    occurrence_attributes = {
      file:             @params['file'],
      line:             @params['line'],
      href:             @params['href'],
      parameters:       @params['parameters'],
      language:         @params['language'],
      platform:         @params['platform'],
      product:          @params['product'],
      protocol:         @params['protocol'],
      app_name:         @params['app_name'],
      cookie_enabled:   @params['cookie_enabled'],
      user_agent:       @params['user_agent'],
      user_address:     @params['user_address'],
      window_event:     @params['window_event'],
      stack_trace:      @params['stack_trace'],
      browser_time:     @params['browser_time'].to_s
    }
    
    # Build the occurrence
    @occurrence = @error.occurrences.build(occurrence_attributes)
    
    # Save the resource, account for errors
    @error.save && @occurrence.save

    # Render the response, well assume it saves
    render json: {error: @error.as_json(only: error_permissions(:only))}, status: 201, callback: params[:callback]
  end
end