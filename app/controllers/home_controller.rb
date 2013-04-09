class HomeController < ApplicationController
  def index
  end
  
  def errors
    render nothing: true
  end
end