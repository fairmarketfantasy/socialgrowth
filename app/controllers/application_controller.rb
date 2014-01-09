class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home
  end

  def destroy
	  sign_out @user
	  redirect_to root_url, :notice => "Signed out!"
	end

  def healthcheck
    User.uncached do
      User.first # Test DB
    end
    render :text => "HealthCheck: OK", :status => :ok
  end 

  private

	  def current_authentication(request)
	    omniauth = request.env["omniauth.auth"]
	    auth = Authentication.find_by_provider_and_uid(omniauth.provider, omniauth.uid) if omniauth
	    return auth.provider if auth
	    return nil
	  end
end
