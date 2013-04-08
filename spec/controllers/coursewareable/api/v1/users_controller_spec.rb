require 'spec_helper'

describe Coursewareable::Api::V1::UsersController do
  let(:user) { Fabricate(:confirmed_user) }
  let(:token) { stub(:accessible? => true, :resource_owner_id => user.id) }

  before do
    controller.stub(:doorkeeper_token) { token }
  end

  describe '#index' do
    before { get :index }

    context 'authenticated' do
      its(:status) { should eq(200) }

      it 'renders user profile' do
        body = JSON.parse(response.body)
        body['user']['id'].should eq(user.id)
        body['user']['email'].should eq(user.email)
        body['user']['first_name'].should eq(user.first_name)
        body['user']['last_name'].should eq(user.last_name)
      end
    end

    context 'not authenticated' do
      let(:token) { stub(:accessible? => false) }

      its(:status) { should eq(401) }
    end
  end
end
