# OAuth controller to handle external authentications
class Coursewareable::OauthsController < ::ApplicationController
  # Using user credentials and OAuth app key
  # we authenticate the user and generate a token if none exists
  def authenticate
    user = login(params[:email], params[:password])
    app = Doorkeeper::Application.where(:uid => params[:client_id] ).first

    # We do not want open sessions
    logout

    if user and app
      token = app.authorized_tokens.where(:resource_owner_id => user.id).last

      # Generate a new token if none found
      if token.nil?
        token = app.authorized_tokens.create(:resource_owner_id => user.id)
      end

      # Refresh token anyway to avoid expired tokens
      render :json => { :error => false, :access_token => token.token}
    else
      render :status => 400, :json => { :error => true }
    end
  end

  # Sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end

  # Handles oauth callback from provider
  def callback
    provider = params[:provider]
    if user = login_from(provider)
      render(:json => {
        :error => false, :provider => provider, :created => false } )
    else
      begin
        user = create_from(provider)
        user.activate!

        # protect from session fixation attack
        reset_session

        auto_login(user)

        render(:json => {
          :error => false, :provider => provider, :created => true } )
      rescue
        render(:status => 400, :json => {
          :error => true, :provider => provider, :created => false } )
      end
    end
  end

end
