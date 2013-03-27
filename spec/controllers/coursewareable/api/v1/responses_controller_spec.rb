require 'spec_helper'

describe Coursewareable::Api::V1::ResponsesController do
  # Try to avoid rewrite response of request.
  # response_var = response variable
  let(:response_var) { Fabricate('coursewareable/response') }
  let(:token) do
    stub :accessible? => true,
    :resource_owner_id => response_var.user.id
  end

  describe '#show' do
    before do
      controller.stub(:doorkeeper_token) { token }
      get(:show, :assignment_id => response_var.assignment.id)
    end

    context 'authenticated' do
      its(:status) { should eq(200) }
      it 'should render requested responses' do
        body = JSON.parse(response.body)
        body['responses'].first['content'].should eq(response_var.content)
      end
    end

    context 'not authenticated' do
      let(:token) { stub(:accessible? => false) }

      its(:status) { should eq(401) }
    end
  end
end
