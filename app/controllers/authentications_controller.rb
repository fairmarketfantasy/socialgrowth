class AuthenticationsController < ApplicationController
  before_action :authenticated, only: [:index]

  def index
    @user = current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    provider = "#{omniauth["provider"].capitalize()}Authentication"
    authentication = Authentication.find_by_provider_and_uid(provider, omniauth["uid"])

    if authentication
      flash[:notice] = "Signed in successfully"
      sign_in_and_redirect(:user, authentication.user)
    else
      user = User.new
      user.assign_name omniauth

      user.authentications.build(provider: omniauth[:provider].capitalize + "Authentication", uid: omniauth[:uid],
        access_token: omniauth[:credentials][:token], access_secret: omniauth[:credentials][:secret])

      if user.save
        flash[:notice] = "Signed in successfully"
        sign_in_and_redirect(:user, user)
      else
        flash[:notice] = "Sign in failed"
        redirect_to application_home_path
      end
    end
  end

  def destroy
    @authentication = Authentication.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully destroyed authentication."
  end

  def show
  end

  def unauthenticated
  end

  private

    def authenticated
      if current_user == nil
        redirect_to application_home_path
      end
    end
end
