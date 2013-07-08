require 'spec_helper'

describe Coursewareable::Api::V1::LecturesController do

  routes { Coursewareable::Engine.routes }

  describe 'routing' do

    it 'routes to #index' do
      get('/v1/lectures').should(
        route_to('coursewareable/api/v1/lectures#index'))
    end

    it 'routes to #show' do
      get('/v1/lectures/1').should(
        route_to('coursewareable/api/v1/lectures#show', :id => '1'))
    end
  end
end
