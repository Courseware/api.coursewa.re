require 'spec_helper'

describe Coursewareable::Api::V1::AssignmentsController do
  let(:assignment) { Fabricate('coursewareable/assignment') }
  let(:token) do
    stub(:accessible? => true,:resource_owner_id => assignment.user.id)
  end
  before { controller.stub(:doorkeeper_token) { token } }

  describe '#index' do
    before do
      get(:index)
    end

    context 'authenticated' do
      its(:status) { should eq(200) }

      it 'renders all assignments' do
        body = JSON.parse(response.body)
        body['assignments'].first['slug'].should eq(assignment.slug)
      end
    end

    context 'not authenticated' do
      let(:token) { stub(:accessible? => false) }

      its(:status) { should eq(401) }
    end
  end

  describe '#show' do
    let(:params) { {:id => assignment.id} }
    before do
      get(:show, params)
    end

    context 'authenticated' do
      its(:status) { should eq(200) }

      it 'renders requested assignment' do
        body = JSON.parse(response.body)
        body['assignment']['slug'].should eq(assignment.slug)
      end

      context 'classroom id provided' do
        let(:params) do
          { :id => assignment.id, :classroom_id => assignment.classroom.id }
        end

        it 'renders requested assignment' do
          body = JSON.parse(response.body)
          body['assignment']['slug'].should eq(assignment.slug)
        end
      end
    end

    context 'not authenticated' do
      let(:token) { stub(:accessible? => false) }

      its(:status) { should eq(401) }
    end
  end
end
