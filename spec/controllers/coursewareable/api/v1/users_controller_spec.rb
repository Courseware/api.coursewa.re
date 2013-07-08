require 'spec_helper'

describe Coursewareable::Api::V1::UsersController do

  routes { Coursewareable::Engine.routes }

  let(:user) { Fabricate(:confirmed_user) }
  let(:token) { double(:accessible? => true, :resource_owner_id => user.id) }

  before do
    controller.stub(:doorkeeper_token) { token }
  end

  describe '#index' do
    before { get :index }

    context 'authenticated' do
      its(:status) { should eq(200) }

      it 'renders user profile' do
        body = JSON.parse(response.body)

        body['users'].count.should eq(1)
        body['users'].first['id'].should eq(user.id)
        body['users'].first['email'].should eq(user.email)
        body['users'].first['first_name'].should eq(user.first_name)
        body['users'].first['last_name'].should eq(user.last_name)
      end
    end

    context 'not authenticated' do
      let(:token) { double(:accessible? => false) }

      its(:status) { should eq(401) }
    end
  end
end
