module Coursewareable
  # OAuth controller to handle external authentications
  class OauthsController < ::ApplicationController

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
          render(:json => {
            :error => true, :provider => provider, :created => false } )
        end
      end
    end

  end
end
