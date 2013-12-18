class AuthenticationsController < ApplicationController
  def index
    @user = current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth["provider"], omniauth["uid"])
    
    if authentication
      flash[:notice] = "Signed in successfully"
      sign_in_and_redirect(:user, authentication.user)
    else
      user = User.new
      user.assign_name omniauth
      user.assign_nickname omniauth
      user.authentications.build(:provider => omniauth["provider"], :uid => omniauth["uid"])

      if user.save
        flash[:notice] = "Signed in successfully"
        sign_in_and_redirect(:user, user)
      else
        flash[:notice] = "Sign in failed"
      end
    end
  end

  def destroy
    @authentication = Authentication.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully destroyed authentication."
  end
end
