require 'spec_helper'

describe Coursewareable::Api::V1::ResponsesController do

  routes { Coursewareable::Engine.routes }

  let(:assignment) { Fabricate(:assignment_with_quiz) }
  let(:resp) { Fabricate('coursewareable/response', :assignment => assignment) }
  let(:token) do
    double(:accessible? => true, :resource_owner_id => resp.user.id)
  end

  before { controller.stub(:doorkeeper_token) { token } }

  describe '#show' do
    before do
      get(:show, :assignment_id => resp.assignment.id)
    end

    context 'authenticated' do
      its(:status) { should eq(200) }

      it 'renders requested responses' do
        body = JSON.parse(response.body)
        body['response']['content'].should eq(resp.content)
        body['response']['quiz'].should_not be_empty
      end
    end

    context 'not authenticated' do
      let(:token) { double(:accessible? => false) }

      its(:status) { should eq(401) }
    end
  end
end
