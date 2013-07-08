require 'spec_helper'

describe Coursewareable::Api::V1::UsersController do

  routes { Coursewareable::Engine.routes }

  describe 'routing' do
    it 'for profile' do
      get('/v1/users').should route_to('coursewareable/api/v1/users#index')
    end
  end
end
