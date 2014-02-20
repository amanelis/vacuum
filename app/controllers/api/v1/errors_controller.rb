class Api::V1::ErrorsController < Api::V1::ApiController  
  before_filter :clean_params,    :only => [:create]
  
  def create        
    # Locate the project
    @project = Project.where(api_key: params[:api_key])[0]
    
    # Find the Error or create it, then handle the occurence
    @error = Error.find_or_create_by(project_id: @project.id, level: params[:level], message: params[:message])    
    
    # Update the count if we are needing to add another occurence, else just continue
    # and add the first occurence
    @error.update_attributes!(count: (@error.count + 1)) unless @error.new_record?
    
    # Occurrence attributes    
    occurrence_attributes = {
      file:               @params['file'],
      line:               @params['line'],
      app_code_name:      @params['app_code_name'],
      app_name:           @params['app_name'],
      app_version:        @params['app_version'],
      browser_time:       @params['browser_time'].try(:to_s).try(:strip),
      browser_time_zone:  @params['browser_time_zone'].try(:to_s).try(:strip),
      charset:            @params['charset'],
      cookie_enabled:     @params['cookie_enabled'],
      cookies:            @params['cookies'],
      href:               @params['href'],
      host:               @params['host'],
      hostname:           @params['hostname'],
      java_enabled:       @params['java_enabled'],
      language:           @params['language'],
      origin:             @params['origin'],
      pathname:           @params['pathname'],
      parameters:         @params['parameters'],
      platform:           @params['platform'],
      port:               @params['port'],
      product:            @params['product'],
      protocol:           @params['protocol'],
      referrer:           @params['referrer'],
      remote_addr:        @params['remote_addr'].try(:to_s).try(:strip),
      screen_height:      @params['screen_height'],
      screen_width:       @params['screen_width'],
      url:                @params['url'],
      user_agent:         @params['user_agent'],
      vendor:             @params['vendor'],
      window_event:       @params['window_event']
     }
    
    # Build the occurrence
    @occurrence = @error.occurrences.build(occurrence_attributes)
    
    # Save the resource, account for errors
    @error.save && @occurrence.save

    # Render the response, well assume it saves
    render json: {error: @error.as_json(only: error_permissions(:only))}, status: 201, callback: params[:callback]
  end
end
