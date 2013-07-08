require 'spec_helper'

describe Coursewareable::OauthsController do

  routes { Coursewareable::Engine.routes }

  describe 'routing' do
    it 'for OAuth callbacks' do
      get('/oauth/callback').should route_to('coursewareable/oauths#callback')
    end

    it 'for OAuth provider handling' do
      get('/oauth/fb').should route_to(
        'coursewareable/oauths#oauth', :provider => 'fb')
    end

    it 'for credential authentication' do
      post('/oauth/authenticate').should route_to(
        'coursewareable/oauths#authenticate')
    end

  end
end
