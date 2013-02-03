class HomeController < ApplicationController
  def index
  end
  
  def errors
    logger.debug 'ERRORS ------------------------------------------------------------------------------------------------------'
    logger.debug params.inspect
    logger.debug 'ERRORS ------------------------------------------------------------------------------------------------------'
    render :text => params.inspect
  end
end
