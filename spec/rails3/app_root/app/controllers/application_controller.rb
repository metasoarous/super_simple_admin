class ApplicationController < ActionController::Base
	include SuperSimpleAdmin::ApplicationController
	
	protect_from_forgery
	
end
