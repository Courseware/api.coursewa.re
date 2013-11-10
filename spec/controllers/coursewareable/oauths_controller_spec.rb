require 'spec_helper'

describe Coursewareable::OauthsController do

  routes { Coursewareable::Engine.routes }

  describe 'credentials call for' do
    describe '#authenticate' do
      let(:user){ Fabricate(:confirmed_user) }
      let(:oauth_app){ Fabricate(:doorkeeper_app) }
      let(:existing_token) { '' }

      before do
        @controller.stub(:form_authenticity_token => true)
        post(:authenticate, :email => user.email, :password => 'secret',
             :client_id => oauth_app.uid, :access_token => existing_token)
      end

      context 'with wrong application key' do
        before(:all) { oauth_app.uid = rand(100) }

        it 'responds with error' do
          response.status.should eq(400)

          body = JSON.parse(response.body)
          body['error'].should be_true
        end
      end

      context 'with wrong user credentials' do
        before(:all) do
          user.stub(:email) { Faker::Internet.email }
        end

        it 'responds with error' do
          response.status.should eq(400)

          body = JSON.parse(response.body)
          body['error'].should be_true
        end
      end

      context 'with existing access token' do
        before(:all) do
          user.stub(:email) { '' }
        end

        context 'which is ok' do
          let(:existing_token) do
            oauth_app.authorized_tokens.create(
              :resource_owner_id => user.id).token
          end

          it 'responds with validated access token' do
            response.status.should eq(200)

            body = JSON.parse(response.body)
            body['error'].should be_false
            body['access_token'].should eq(existing_token)
          end
        end

        context 'which is wrong' do
          let(:existing_token) { rand(100..200) }

          it 'responds with an error' do
            response.status.should eq(400)

            body = JSON.parse(response.body)
            body['error'].should be_true
          end
        end
      end

      it 'generates and responds with an OAuth generated access token' do
        response.status.should eq(200)

        body = JSON.parse(response.body)
        body['error'].should be_false

        access_token = body['access_token']
        access_token.should_not be_blank

        tokens = Doorkeeper::AccessToken.where(
          :resource_owner_id => user.id, :application_id => oauth_app.id)
        tokens.count.should eq(1)

        token = tokens.first
        token.should_not be_expired
        token.should_not be_revoked
      end
    end
  end #credentials

end
