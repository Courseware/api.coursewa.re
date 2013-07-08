require 'spec_helper'

describe Coursewareable::Api::V1::ResponsesController do

  routes { Coursewareable::Engine.routes }

  describe 'routing' do
    it '#show' do
      get('/v1/response').should(
        route_to('coursewareable/api/v1/responses#show'))
    end
  end
end
