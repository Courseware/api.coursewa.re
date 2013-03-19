require 'spec_helper'

describe Coursewareable::Api::V1::UsersController do
  describe '#me' do
    let(:token) { stub(:accessible? => true) }

    before do
      controller.stub(:doorkeeper_token) { token }
      get :me
    end

    context 'authenticated' do
      its(:status) { should eq(200) }
    end

    context 'not authenticated' do
      let(:token) { stub(:accessible? => false) }

      its(:status) { should eq(401) }
    end
  end
end
