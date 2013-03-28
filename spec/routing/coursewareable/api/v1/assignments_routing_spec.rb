require "spec_helper"

describe Coursewareable::Api::V1::AssignmentsController do
  describe "routing" do

    it "#index" do
      get("/v1/assignments").should(
        route_to("coursewareable/api/v1/assignments#index"))
    end

    it "#show" do
      get("/v1/assignments/1").should(
        route_to("coursewareable/api/v1/assignments#show", :id => "1"))
    end
  end
end
