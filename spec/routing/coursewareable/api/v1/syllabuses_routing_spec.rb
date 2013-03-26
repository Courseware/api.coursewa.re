require "spec_helper"

describe Coursewareable::Api::V1::SyllabusesController do
  describe "routing" do
    it "routes to #show" do
      get("/v1/syllabuses/1").should(
        route_to("coursewareable/api/v1/syllabuses#show", :id => "1"))
    end
  end
end
