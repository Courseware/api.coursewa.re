require 'spec_helper'

describe Coursewareable::Api::V1::ClassroomsController do

  routes { Coursewareable::Engine.routes }

  describe 'routing' do
    it 'for index' do
      get('/v1/classrooms').should(
        route_to('coursewareable/api/v1/classrooms#index'))
    end

    it 'for show' do
      get('/v1/classrooms/1').should(
        route_to('coursewareable/api/v1/classrooms#show', :id => "1"))
    end

    it 'for collaborators' do
      get('/v1/classrooms/1/collaborators').should(
        route_to('coursewareable/api/v1/classrooms#collaborators',
          :classroom_id => "1"))
    end

    it 'for timeline' do
      get('/v1/classrooms/1/timeline').should(
        route_to('coursewareable/api/v1/classrooms#timeline',
          :classroom_id => "1"))
    end
  end
end
