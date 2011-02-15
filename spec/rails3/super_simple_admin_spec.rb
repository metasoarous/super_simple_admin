require File.dirname(__FILE__) + "/spec_helper"

describe SessionsController do
	integrate_views
	
	it "should return a new session form" do
		get "new"
		response.should be_success
		response.should have_text("Password")
	end
	
	
end


