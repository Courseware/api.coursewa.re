require 'spec_helper'

describe Coursewareable::Api::V1::AssignmentsController do
  let(:assignment) { Fabricate('coursewareable/assignment') }
  let(:token) do
    stub :accessible? => true,
    :resource_owner_id => assignment.lecture.classroom.owner.id
  end

  describe "GET index" do
    before do
      controller.stub(:doorkeeper_token) { token }
      get(:index)
    end

    context 'authenticated' do
      its(:status) { should eq(200) }
      it "should render all assignments" do
        body = JSON.parse(response.body)
        body['assignments'].first['slug'].should eq(assignment.slug)
      end
    end

    context 'not authenticated' do
      let(:token) { stub(:accessible? => false) }

      its(:status) { should eq(401) }
    end
  end

  describe "GET show" do
    before do
      controller.stub(:doorkeeper_token) { token }
      get(:show, :id => assignment.id)
    end

    context 'authenticated' do
      its(:status) { should eq(200) }
      it 'should render requested assignment' do
        body = JSON.parse(response.body)
        body['assignment']['slug'].should eq(assignment.slug)
      end
    end

    context 'not authenticated' do
      let(:token) { stub(:accessible? => false) }

      its(:status) { should eq(401) }
    end
  end
end
