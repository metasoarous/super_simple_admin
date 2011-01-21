# Parent Module. Right now just contains the ApplicationController and
# SessionsController submodules.
module SuperSimpleAdmin
  # This sets default configuration parameters for the gem and
  # makes them accessible in the application through the
  # SuperSimpleAdmin.config hash
  class << self; attr_accessor :config end
  @config = {
    :password => "secret",
    :unauthorized_message => "Unauthorized access",
    :unauthorized_redirect => "/",
    :login_success_message => "Successfully logged in",
    :login_success_redirect => "/",
    :login_failure_message => "Incorrect password",
    :login_failure_redirect => "/sessions/new",
    :logout_message => "Logout successful",
    :logout_redirect => "/"
  }
  # This sets the Admin variables based off of the values set in the
  # admin_config.yml file if there is one and overrides any default
  # values set above
  begin
    raw_config = File.read(Rails.root.to_s + "/config/admin_config.yml")
    yml = YAML.load(raw_config)
    @config.merge yml["all_environments"].symbolize_keys
    @config.merge yml[RAILS_ENV].symbolize_keys
  rescue Errno::ENOENT
  end
  
  # Load this module into your application controller
  module ApplicationController
    # Sets up the admin? helper method for use in views
    def self.included(controller)
      controller.send :helper_method, :admin?
    end
    protected
    # This method can be used in before 
    # filters in other controllers to restrict access.
    # May update this later to be operable with
    # CanCan or AuthLogic.
    def authorize
      unless admin?
        flash[:notice] = SuperSimpleAdmin.config[:unauthorized_message]
        redirect_to SuperSimpleAdmin.config[:unauthorized_redirect]
        false
      end
    end
    # The admin method tells us whether we are logged in.
    def admin?
      session[:password] == SuperSimpleAdmin.config[:password]
    end
  end
  
  
  # This contains code for the sessions controller to hook into
  module SessionsController
    def create
      session[:password] = params[:password]
      if session[:password] == SuperSimpleAdmin.config[:password]
        flash[:notice] = SuperSimpleAdmin.config[:login_success_message]
        redirect_to SuperSimpleAdmin.config[:login_success_redirect]
      else 
        flash[:notice] = SuperSimpleAdmin.config[:login_failure_message]
        redirect_to SuperSimpleAdmin.config[:login_failure_redirect]
      end
    end

    def destroy
      reset_session
      flash[:notice] = SuperSimpleAdmin.config[:logout_message]
      redirect_to SuperSimpleAdmin.config[:logout_redirect]
    end

    def new

    end
  end
end