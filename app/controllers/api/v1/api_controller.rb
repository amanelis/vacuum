class Api::V1::ApiController < ApplicationController
  # Set the version
  API_VERSION = 'v1'
  
  # Verify the correct parameters have been passed and there is a user 
  # allowed to access the system
  before_filter :check_params
  
  # project_permissions
  # @param: Symbol[scope]
  # @return:
  # Here you can define what attributes via as_json method
  # are allowed to be shown given a certain user type
  def project_permissions scope
    case scope
    when :only
      [:name, :url, :api_key, :identifier]
    when :include
      {}
    when :methods
      []
    end
  end
  
  # error_permissions
  # @param: Symbol[scope]
  # @return:
  # Here you can define what attributes via as_json method
  # are allowed to be shown given a certain user type
  def error_permissions scope
    case scope
    when :only
      [:identifier, :url]
    when :include
      {}
    when :methods
      []
    end
  end
  
  protected
    ### VERIFICATION METHODS ###################################
    def verify_authentic
      check_params
      render :json => {
        "error" => {
          "version" => API_VERSION,
          "message" => "Invalid OAuth access token.",
          "type" => "OAuthException",
          "method" => "verify_authentic"
        }
      }
    end
  
    def check_params
      if params.blank? || params[:api_key].blank?
        render :json => {
          "error" => {
            "version" => API_VERSION,
            "message" => "Invalid or blank parameters passed.",
            "type" => "BlankParameters",
            "method" => "check_params"
          }
        }
      end
    end
  
    def no_record
      render :json => {
        "error" => {
          "version" => API_VERSION,
          "message" => "No record found.",
          "type" => "EmptySet",
          "method" => "no_record"
        }
      }
    end
    
    def not_authorized
      render :json => {
        "error" => {
          "version" => API_VERSION,
          "message" => "Not authorized for this resource.",
          "type" => "PermissionsException",
          "method" => not_authorized
        }
      }
    end
    
    def depricated
      render :json => {
        "error" => {
          "version" => API_VERSION,
          "message" => "Resource/Method has been removed from this version of the API.",
          "type" => "DepricatedMethod",
          "method" => "depricated"
        }
      }
    end
    
    def not_authenticated
      render :json => {
        "error" => {
          "version" => API_VERSION,
          "message" => "User has not been authenticated.",
          "type" => "OAuthException",
          "method" => "not_authenticated"
        }
      }
    end
    
    def version_not_allowed
      render :json => {
        "error" => {
          "version" => API_VERSION,
          "message" => "API_KEY not authorized for this version of API.",
          "type" => "PermissionsException",
          "method" => "version_not_allowed"
        }
      }
    end
    
    def invalid_request(request)
      render :json => {
        "error" => {
          "version" => API_VERSION,
          "message" => "Invalid HTTP request, expected #{request}.",
          "type" => "HTTPRequestException",
          "method" => "invalid_request"
        }
      }
    end
    
    def render_data(type, data)
      render :json => {
        "response" => {
          type => data
        },
        "status" => {
          "code" => 0,
          "message" => :success,
          "version" => API_VERSION
        }
      }, :callback => params[:callback]
    end
    ### VERIFICATION METHODS ###################################

    def sign_request(api_token, date)
      digest = OpenSSL::Digest::Digest.new('sha256')
      Base64.encode64(OpenSSL::HMAC.digest(digest, api_token, date)).chomp
    end
    
    def versioned_accept_header?(request)
      accept = request.headers['Accept']
      accept && accept[/application\/vnd\.flying-sphinx-v#{@version}\+json/]
    end

    def unversioned_accept_header?(request)
      accept = request.headers['Accept']
      accept.blank? || accept[/application\/vnd\.flying-sphinx/].nil?
    end

    def version_one?(request)
      @version == 1 && unversioned_accept_header?(request)
    end
    
    def version_two?(request)
      @version == 2 && unversioned_accept_header?(request)
    end
end