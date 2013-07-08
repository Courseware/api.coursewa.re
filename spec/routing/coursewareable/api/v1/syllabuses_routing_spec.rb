require 'spec_helper'

describe Coursewareable::Api::V1::SyllabusesController do

  routes { Coursewareable::Engine.routes }

  describe "routing" do
    it "routes to #show" do
      get("/v1/syllabus").should(
        route_to("coursewareable/api/v1/syllabuses#show"))
    end
  end
end
